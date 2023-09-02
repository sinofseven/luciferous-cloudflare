import { Request, Response, R2Bucket, ExecutionContext, URL, Headers } from "@cloudflare/workers-types";

export interface Env {
  MY_BUCKET: R2Bucket;
}

const HEADERS_JSON_CONTENT_TYPE = {
  "Content-Type": "application/json",
};

export default {
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    try {
      const url = new URL(request.url);
      let key = url.pathname.slice(1);

      if (request.method !== "GET") {
        return new Response(JSON.stringify({ message: "invalid method" }), { status: 405, headers: HEADERS_JSON_CONTENT_TYPE });
      }

      let object = await env.MY_BUCKET.get(key);
      if (object === null) {
        if (key[key.length - 1] !== "/") {
          key += "/";
        }
        key += "index.html";
        object = await env.MY_BUCKET.get(key);
        if (object === null) {
          return new Response(JSON.stringify({ message: "not found" }), { status: 404, headers: HEADERS_JSON_CONTENT_TYPE });
        }
      }

      const headers = new Headers();
      object.writeHttpMetadata(headers);
      headers.set("etag", object.httpEtag);

      return new Response(object.body, { headers });
    } catch (e) {
      return new Response(JSON.stringify({ message: "internal server error in Cloudflare worker" }), {
        status: 500,
        headers: HEADERS_JSON_CONTENT_TYPE,
      });
    }
  },
};
