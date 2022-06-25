import {MessagingPayload} from "firebase-admin/lib/messaging/messaging-api";
import * as functions from "firebase-functions";
import {admin} from "./deps/firebase";

export interface PushPayload {
  title: string;
  content: string;
}

export const push = functions.https.onRequest(async (request, response) => {
  const project = request.query.project;
  const type = request.query.type;
  const title = request.query.title as string;
  const content = request.query.content as string;
  const topic = `${project}-${type}`;
  const payload: PushPayload = {
    title: title,
    content: content,
  };
  const message: MessagingPayload = {
    notification: {
      title: payload.title,
      body: payload.content,
      key: "1",
    },
  };
  const messageId = await admin.messaging().sendToTopic(topic, message);
  response.status(200).send(`Send message with ID: ${messageId} to topic ${topic}!`);
});
