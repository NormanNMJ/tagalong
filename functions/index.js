const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Function to increment likes on a post
exports.incrementLikes = functions.https.onCall(async (data, context) => {
  const postId = data.postId;
  const userId = context.auth.uid;

  // Check if the user is authenticated
  //   if (!userId) {
  //     throw functions.https.HttpsError("user not authenticated");
  //   }

  // Increment likes on the post
  const postRef = admin.firestore().collection("posts").doc(postId);
  await postRef.update({
    likes: admin.firestore.FieldValue.increment(1),
  });

  // Store like in user's likes list
  const userLikesRef = admin.firestore().collection("users").doc(userId);
  await userLikesRef.update({
    likedPosts: admin.firestore.FieldValue.arrayUnion(postId),
  });

  return {success: true};
});

// Function to decrement likes on a post (unlike)
exports.decrementLikes = functions.https.onCall(async (data, context) => {
  const postId = data.postId;
  const userId = context.auth.uid;

  // Check if the user is authenticated
  //   if (!userId) {
  //     throw functions.https.HttpsError("User not authenticated");
  //   }

  // Decrement likes on the post
  const postRef = admin.firestore().collection("posts").doc(postId);
  await postRef.update({
    likes: admin.firestore.FieldValue.increment(-1),
  });

  // Remove like from user's likes list
  const userLikesRef = admin.firestore().collection("users").doc(userId);
  await userLikesRef.update({
    likedPosts: admin.firestore.FieldValue.arrayRemove(postId),
  });

  return {success: true};
});
