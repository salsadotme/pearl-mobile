import {MessagingPayload} from "firebase-admin/lib/messaging/messaging-api";
import * as functions from "firebase-functions";
import {admin} from "./deps/firebase";

export interface PushPayload {
  title: string;
  content: string;
  topic: string;
}

export const push = functions.runWith({
  invoker: "public",
}).https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");

  const topic = "all";
  const payload: PushPayload = {title: "Hello World", content: "foobar", topic: topic};

  const message: MessagingPayload = {
    notification: {
      title: payload.title,
      body: payload.content,
      key: "1",
    },
  };
  admin.messaging().sendToTopic(topic, message);
});
