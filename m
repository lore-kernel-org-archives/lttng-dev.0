From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/5] Fix: LPOLLHUP and LPOLLERR when
	there is still data in pipe/socket
Date: Wed,  9 Sep 2015 11:56:33 -0400
Message-ID: <1441814197-9941-1-git-send-email-mathieu.desnoyers__19409.7101492391$1441814349$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZZhjt-0006XR-9Y
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 11:56:52 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The event mask returned by poll/epoll is a bitwise mask made of all the
events observed. On bidirectional sockets, there are cases where
combinations of LPOLLHUP/LPOLLERR and LPOLLIN/LPOLLPRI can be raised at
the same time.

Currently the overall behavior in sessiond, consumerd and relayd is to
handle LPOLLHUP or LPOLLERR immediately, whether or not there is still
data to read in the socket. Unfortunately, this behavior may discard the
last information made available on the pipe or socket.

Audit all uses of LPOLLHUP and LPOLLERR on sockets on which we expect
data to ensure that we deal with LPOLLIN or LPOLLPRI, and catch the
hangup when read or recvmsg returns 0. Keep the LPOLLHUP and LPOLLERR
handling, but only when LPOLLIN is not raised, just in case some
unforeseen error happens when sending the reply.

This is one correct case where we can handle LPOLLHUP and LPOLLERR
directly without caring about LPOLLIN: sockets where we are expected to
write and then read the reply (e.g. command sockets). It is then OK
for a dedicated thread to watch for LPOLLHUP and LPOLLERR.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c |   3 +-
 src/bin/lttng-relayd/health-relayd.c       |   7 +-
 src/bin/lttng-relayd/live.c                |  36 +++++----
 src/bin/lttng-relayd/main.c                |  97 ++++++++++++++---------
 src/bin/lttng-sessiond/agent-thread.c      |  45 ++++++-----
 src/bin/lttng-sessiond/ht-cleanup.c        |  43 +++++-----
 src/bin/lttng-sessiond/main.c              | 102 ++++++++++++++++--------
 src/bin/lttng-sessiond/ust-thread.c        |  91 +++++++++++-----------
 src/common/consumer.c                      | 121 +++++++++++++++++------------
 9 files changed, 319 insertions(+), 226 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index fc9a266..5be1c97 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -275,7 +275,8 @@ restart:
 
 			/* Event on the registration socket */
 			if (pollfd == sock) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)
+						&& !(revents & LPOLLIN)) {
 					ERR("Health socket poll error");
 					goto error;
 				}
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index d34a376..be0b0b1 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -346,9 +346,14 @@ restart:
 
 			/* Event on the registration socket */
 			if (pollfd == sock) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & LPOLLIN) {
+					continue;
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 					ERR("Health socket poll error");
 					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			}
 		}
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index a1fbbbe..8da2d62 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -542,10 +542,7 @@ restart:
 				goto exit;
 			}
 
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-				ERR("socket poll error");
-				goto error;
-			} else if (revents & LPOLLIN) {
+			if (revents & LPOLLIN) {
 				/*
 				 * A new connection is requested, therefore a
 				 * viewer connection is allocated in this
@@ -588,6 +585,12 @@ restart:
 				 * exchange in cds_wfcq_enqueue.
 				 */
 				futex_nto1_wake(&viewer_conn_queue.futex);
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				ERR("socket poll error");
+				goto error;
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
@@ -1908,10 +1911,7 @@ restart:
 
 			/* Inspect the relay conn pipe for new connection. */
 			if (pollfd == live_conn_pipe[0]) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					ERR("Relay live pipe error");
-					goto error;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					struct relay_connection *conn;
 
 					ret = lttng_read(live_conn_pipe[0],
@@ -1923,6 +1923,12 @@ restart:
 							LPOLLIN | LPOLLRDHUP);
 					connection_ht_add(viewer_connections_ht, conn);
 					DBG("Connection socket %d added to poll", conn->sock->fd);
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					ERR("Relay live pipe error");
+					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			} else {
 				/* Connection activity. */
@@ -1933,11 +1939,7 @@ restart:
 					continue;
 				}
 
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					cleanup_connection_pollfd(&events, pollfd);
-					/* Put "create" ownership reference. */
-					connection_put(conn);
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					ret = conn->sock->ops->recvmsg(conn->sock, &recv_hdr,
 							sizeof(recv_hdr), 0);
 					if (ret <= 0) {
@@ -1956,6 +1958,14 @@ restart:
 							DBG("Viewer connection closed with %d", pollfd);
 						}
 					}
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					cleanup_connection_pollfd(&events, pollfd);
+					/* Put "create" ownership reference. */
+					connection_put(conn);
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					connection_put(conn);
+					goto error;
 				}
 				/* Put local "get_by_sock" reference. */
 				connection_put(conn);
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 2ce9bf0..dcaaaa8 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -864,10 +864,7 @@ restart:
 				goto exit;
 			}
 
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-				ERR("socket poll error");
-				goto error;
-			} else if (revents & LPOLLIN) {
+			if (revents & LPOLLIN) {
 				/*
 				 * A new connection is requested, therefore a
 				 * sessiond/consumerd connection is allocated in
@@ -919,6 +916,12 @@ restart:
 				 * exchange in cds_wfcq_enqueue.
 				 */
 				futex_nto1_wake(&relay_conn_queue.futex);
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				ERR("socket poll error");
+				goto error;
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
@@ -2429,10 +2432,7 @@ restart:
 
 			/* Inspect the relay conn pipe for new connection */
 			if (pollfd == relay_conn_pipe[0]) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					ERR("Relay connection pipe error");
-					goto error;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					struct relay_connection *conn;
 
 					ret = lttng_read(relay_conn_pipe[0], &conn, sizeof(conn));
@@ -2443,6 +2443,12 @@ restart:
 							LPOLLIN | LPOLLRDHUP);
 					connection_ht_add(relay_connections_ht, conn);
 					DBG("Connection socket %d added", conn->sock->fd);
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					ERR("Relay connection pipe error");
+					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			} else {
 				struct relay_connection *ctrl_conn;
@@ -2451,29 +2457,8 @@ restart:
 				/* If not found, there is a synchronization issue. */
 				assert(ctrl_conn);
 
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					relay_thread_close_connection(&events, pollfd, ctrl_conn);
-					if (last_seen_data_fd == pollfd) {
-						last_seen_data_fd = last_notdel_data_fd;
-					}
-				} else if (revents & LPOLLIN) {
-					if (ctrl_conn->type == RELAY_CONTROL) {
-						ret = ctrl_conn->sock->ops->recvmsg(ctrl_conn->sock, &recv_hdr,
-								sizeof(recv_hdr), 0);
-						if (ret <= 0) {
-							/* Connection closed */
-							relay_thread_close_connection(&events, pollfd,
-								ctrl_conn);
-						} else {
-							ret = relay_process_control(&recv_hdr, ctrl_conn);
-							if (ret < 0) {
-								/* Clear the session on error. */
-								relay_thread_close_connection(&events, pollfd,
-									ctrl_conn);
-							}
-							seen_control = 1;
-						}
-					} else {
+				if (ctrl_conn->type == RELAY_DATA) {
+					if (revents & LPOLLIN) {
 						/*
 						 * Flag the last seen data fd not deleted. It will be
 						 * used as the last seen fd if any fd gets deleted in
@@ -2481,9 +2466,39 @@ restart:
 						 */
 						last_notdel_data_fd = pollfd;
 					}
+					goto put_ctrl_connection;
+				}
+				assert(ctrl_conn->type == RELAY_CONTROL);
+
+				if (revents & LPOLLIN) {
+					ret = ctrl_conn->sock->ops->recvmsg(ctrl_conn->sock,
+							&recv_hdr, sizeof(recv_hdr), 0);
+					if (ret <= 0) {
+						/* Connection closed */
+						relay_thread_close_connection(&events, pollfd,
+								ctrl_conn);
+					} else {
+						ret = relay_process_control(&recv_hdr, ctrl_conn);
+						if (ret < 0) {
+							/* Clear the session on error. */
+							relay_thread_close_connection(&events,
+									pollfd, ctrl_conn);
+						}
+						seen_control = 1;
+					}
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					relay_thread_close_connection(&events,
+							pollfd, ctrl_conn);
+					if (last_seen_data_fd == pollfd) {
+						last_seen_data_fd = last_notdel_data_fd;
+					}
 				} else {
-					ERR("Unknown poll events %u for sock %d", revents, pollfd);
+					ERR("Unexpected poll events %u for control sock %d",
+							revents, pollfd);
+					connection_put(ctrl_conn);
+					goto error;
 				}
+			put_ctrl_connection:
 				connection_put(ctrl_conn);
 			}
 		}
@@ -2533,17 +2548,17 @@ restart:
 				/* Skip it. Might be removed before. */
 				continue;
 			}
+			if (data_conn->type == RELAY_CONTROL) {
+				goto put_data_connection;
+			}
+			assert(data_conn->type == RELAY_DATA);
 
 			if (revents & LPOLLIN) {
-				if (data_conn->type != RELAY_DATA) {
-					goto put_connection;
-				}
-
 				ret = relay_process_data(data_conn);
 				/* Connection closed */
 				if (ret < 0) {
 					relay_thread_close_connection(&events, pollfd,
-						data_conn);
+							data_conn);
 					/*
 					 * Every goto restart call sets the last seen fd where
 					 * here we don't really care since we gracefully
@@ -2555,8 +2570,14 @@ restart:
 					connection_put(data_conn);
 					goto restart;
 				}
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				relay_thread_close_connection(&events, pollfd,
+						data_conn);
+			} else {
+				ERR("Unknown poll events %u for data sock %d",
+						revents, pollfd);
 			}
-		put_connection:
+		put_data_connection:
 			connection_put(data_conn);
 		}
 		last_seen_data_fd = -1;
diff --git a/src/bin/lttng-sessiond/agent-thread.c b/src/bin/lttng-sessiond/agent-thread.c
index d1bb122..2b6f776 100644
--- a/src/bin/lttng-sessiond/agent-thread.c
+++ b/src/bin/lttng-sessiond/agent-thread.c
@@ -296,35 +296,22 @@ restart:
 				goto exit;
 			}
 
-			/*
-			 * Check first if this is a POLLERR since POLLIN is also included
-			 * in an error value thus checking first.
-			 */
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-				/* Removing from the poll set */
-				ret = lttng_poll_del(&events, pollfd);
-				if (ret < 0) {
-					goto error;
-				}
-
-				agent_destroy_app_by_sock(pollfd);
-			} else if (revents & (LPOLLIN)) {
+			if (revents & LPOLLIN) {
 				int new_fd;
 				struct agent_app *app = NULL;
 
-				/* Pollin event of agent app socket should NEVER happen. */
 				assert(pollfd == reg_sock->fd);
-
 				new_fd = handle_registration(reg_sock, &app);
 				if (new_fd < 0) {
-					WARN("[agent-thread] agent registration failed. Ignoring.");
-					/* Somehow the communication failed. Just continue. */
 					continue;
 				}
 				/* Should not have a NULL app on success. */
 				assert(app);
 
-				/* Only add poll error event to only detect shutdown. */
+				/*
+				 * Since this is a command socket (write then read),
+				 * only add poll error event to only detect shutdown.
+				 */
 				ret = lttng_poll_add(&events, new_fd,
 						LPOLLERR | LPOLLHUP | LPOLLRDHUP);
 				if (ret < 0) {
@@ -336,10 +323,26 @@ restart:
 				update_agent_app(app);
 
 				/* On failure, the poll will detect it and clean it up. */
-				(void) agent_send_registration_done(app);
+				ret = agent_send_registration_done(app);
+				if (ret < 0) {
+					/* Removing from the poll set */
+					ret = lttng_poll_del(&events, new_fd);
+					if (ret < 0) {
+						goto error;
+					}
+					agent_destroy_app_by_sock(new_fd);
+					continue;
+				}
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				/* Removing from the poll set */
+				ret = lttng_poll_del(&events, pollfd);
+				if (ret < 0) {
+					goto error;
+				}
+				agent_destroy_app_by_sock(pollfd);
 			} else {
-				ERR("Unknown poll events %u for sock %d", revents, pollfd);
-				continue;
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index c5f64da..b5f58d0 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -103,32 +103,31 @@ restart:
 				continue;
 			}
 
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+			if (revents & LPOLLIN) {
+				/* Get socket from dispatch thread. */
+				size_ret = lttng_read(ht_cleanup_pipe[0], &ht,
+						sizeof(ht));
+				if (size_ret < sizeof(ht)) {
+					PERROR("ht cleanup notify pipe");
+					goto error;
+				}
+				health_code_update();
+				/*
+				 * The whole point of this thread is to call
+				 * lttng_ht_destroy from a context that is NOT:
+				 * 1) a read-side RCU lock,
+				 * 2) a call_rcu thread.
+				 */
+				lttng_ht_destroy(ht);
+
+				health_code_update();
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 				ERR("ht cleanup pipe error");
 				goto error;
-			} else if (!(revents & LPOLLIN)) {
-				/* No POLLIN and not a catched error, stop the thread. */
-				ERR("ht cleanup failed. revent: %u", revents);
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
 				goto error;
 			}
-
-			/* Get socket from dispatch thread. */
-			size_ret = lttng_read(ht_cleanup_pipe[0], &ht,
-					sizeof(ht));
-			if (size_ret < sizeof(ht)) {
-				PERROR("ht cleanup notify pipe");
-				goto error;
-			}
-			health_code_update();
-			/*
-			 * The whole point of this thread is to call
-			 * lttng_ht_destroy from a context that is NOT:
-			 * 1) a read-side RCU lock,
-			 * 2) a call_rcu thread.
-			 */
-			lttng_ht_destroy(ht);
-
-			health_code_update();
 		}
 
 		for (i = 0; i < nb_fd; i++) {
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 0e7de6e..13bd649 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1165,31 +1165,33 @@ static void *thread_manage_kernel(void *data)
 			}
 
 			/* Check for data on kernel pipe */
-			if (pollfd == kernel_poll_pipe[0] && (revents & LPOLLIN)) {
-				(void) lttng_read(kernel_poll_pipe[0],
-					&tmp, 1);
-				/*
-				 * Ret value is useless here, if this pipe gets any actions an
-				 * update is required anyway.
-				 */
-				update_poll_flag = 1;
-				continue;
-			} else {
-				/*
-				 * New CPU detected by the kernel. Adding kernel stream to
-				 * kernel session and updating the kernel consumer
-				 */
-				if (revents & LPOLLIN) {
+			if (revents & LPOLLIN) {
+				if (pollfd == kernel_poll_pipe[0]) {
+					(void) lttng_read(kernel_poll_pipe[0],
+						&tmp, 1);
+					/*
+					 * Ret value is useless here, if this pipe gets any actions an
+					 * update is required anyway.
+					 */
+					update_poll_flag = 1;
+					continue;
+				} else {
+					/*
+					 * New CPU detected by the kernel. Adding kernel stream to
+					 * kernel session and updating the kernel consumer
+					 */
 					ret = update_kernel_stream(&kconsumer_data, pollfd);
 					if (ret < 0) {
 						continue;
 					}
 					break;
-					/*
-					 * TODO: We might want to handle the LPOLLERR | LPOLLHUP
-					 * and unregister kernel stream at this point.
-					 */
 				}
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				update_poll_flag = 1;
+				continue;
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
@@ -1319,9 +1321,14 @@ restart:
 
 		/* Event on the registration socket */
 		if (pollfd == consumer_data->err_sock) {
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+			if (revents & LPOLLIN) {
+				continue;
+			} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 				ERR("consumer err socket poll error");
 				goto error;
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
@@ -1451,7 +1458,8 @@ restart_poll:
 
 			if (pollfd == sock) {
 				/* Event on the consumerd socket */
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)
+						&& !(revents & LPOLLIN)) {
 					ERR("consumer err socket second poll error");
 					goto error;
 				}
@@ -1469,6 +1477,11 @@ restart_poll:
 
 				goto exit;
 			} else if (pollfd == consumer_data->metadata_fd) {
+				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)
+						&& !(revents & LPOLLIN)) {
+					ERR("consumer err metadata socket second poll error");
+					goto error;
+				}
 				/* UST metadata requests */
 				ret = ust_consumer_metadata_request(
 						&consumer_data->metadata_sock);
@@ -1636,10 +1649,7 @@ static void *thread_manage_apps(void *data)
 
 			/* Inspect the apps cmd pipe */
 			if (pollfd == apps_cmd_pipe[0]) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					ERR("Apps command pipe error");
-					goto error;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					int sock;
 
 					/* Empty pipe */
@@ -1652,9 +1662,8 @@ static void *thread_manage_apps(void *data)
 					health_code_update();
 
 					/*
-					 * We only monitor the error events of the socket. This
-					 * thread does not handle any incoming data from UST
-					 * (POLLIN).
+					 * Since this is a command socket (write then read),
+					 * we only monitor the error events of the socket.
 					 */
 					ret = lttng_poll_add(&events, sock,
 							LPOLLERR | LPOLLHUP | LPOLLRDHUP);
@@ -1663,6 +1672,12 @@ static void *thread_manage_apps(void *data)
 					}
 
 					DBG("Apps with sock %d added to poll set", sock);
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					ERR("Apps command pipe error");
+					goto error;
+				} else {
+					ERR("Unknown poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			} else {
 				/*
@@ -1678,6 +1693,9 @@ static void *thread_manage_apps(void *data)
 
 					/* Socket closed on remote end. */
 					ust_app_unregister(pollfd);
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			}
 
@@ -1825,6 +1843,9 @@ static void sanitize_wait_queue(struct ust_reg_wait_queue *wait_queue)
 				 */
 				wait_node = NULL;
 				break;
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				goto error;
 			}
 		}
 	}
@@ -2185,10 +2206,7 @@ static void *thread_registration_apps(void *data)
 
 			/* Event on the registration socket */
 			if (pollfd == apps_sock) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-					ERR("Register apps socket poll error");
-					goto error;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					sock = lttcomm_accept_unix_sock(apps_sock);
 					if (sock < 0) {
 						goto error;
@@ -2275,6 +2293,12 @@ static void *thread_registration_apps(void *data)
 					 * barrier with the exchange in cds_wfcq_enqueue.
 					 */
 					futex_nto1_wake(&ust_cmd_queue.futex);
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					ERR("Register apps socket poll error");
+					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			}
 		}
@@ -4177,9 +4201,14 @@ restart:
 
 			/* Event on the registration socket */
 			if (pollfd == sock) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & LPOLLIN) {
+					continue;
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 					ERR("Health socket poll error");
 					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			}
 		}
@@ -4354,9 +4383,14 @@ static void *thread_manage_clients(void *data)
 
 			/* Event on the registration socket */
 			if (pollfd == client_sock) {
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & LPOLLIN) {
+					continue;
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 					ERR("Client socket poll error");
 					goto error;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 			}
 		}
diff --git a/src/bin/lttng-sessiond/ust-thread.c b/src/bin/lttng-sessiond/ust-thread.c
index b421eb2..9c944c5 100644
--- a/src/bin/lttng-sessiond/ust-thread.c
+++ b/src/bin/lttng-sessiond/ust-thread.c
@@ -57,7 +57,8 @@ void *ust_thread_manage_notify(void *data)
 	}
 
 	/* Add notify pipe to the pollset. */
-	ret = lttng_poll_add(&events, apps_cmd_notify_pipe[0], LPOLLIN | LPOLLERR);
+	ret = lttng_poll_add(&events, apps_cmd_notify_pipe[0],
+			LPOLLIN | LPOLLERR | LPOLLHUP | LPOLLRDHUP);
 	if (ret < 0) {
 		goto error;
 	}
@@ -109,45 +110,56 @@ restart:
 			if (pollfd == apps_cmd_notify_pipe[0]) {
 				int sock;
 
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & LPOLLIN) {
+					/* Get socket from dispatch thread. */
+					size_ret = lttng_read(apps_cmd_notify_pipe[0],
+							&sock, sizeof(sock));
+					if (size_ret < sizeof(sock)) {
+						PERROR("read apps notify pipe");
+						goto error;
+					}
+					health_code_update();
+
+					ret = lttng_poll_add(&events, sock,
+							LPOLLIN | LPOLLERR | LPOLLHUP | LPOLLRDHUP);
+					if (ret < 0) {
+						/*
+						 * It's possible we've reached the max poll fd allowed.
+						 * Let's close the socket but continue normal execution.
+						 */
+						ret = close(sock);
+						if (ret) {
+							PERROR("close notify socket %d", sock);
+						}
+						lttng_fd_put(LTTNG_FD_APPS, 1);
+						continue;
+					}
+					DBG3("UST thread notify added sock %d to pollset", sock);
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 					ERR("Apps notify command pipe error");
 					goto error;
-				} else if (!(revents & LPOLLIN)) {
-					/* No POLLIN and not a catched error, stop the thread. */
-					ERR("Notify command pipe failed. revent: %u", revents);
-					goto error;
-				}
-
-				/* Get socket from dispatch thread. */
-				size_ret = lttng_read(apps_cmd_notify_pipe[0],
-						&sock, sizeof(sock));
-				if (size_ret < sizeof(sock)) {
-					PERROR("read apps notify pipe");
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
 					goto error;
 				}
-				health_code_update();
-
-				ret = lttng_poll_add(&events, sock,
-						LPOLLIN | LPOLLERR | LPOLLHUP | LPOLLRDHUP);
-				if (ret < 0) {
-					/*
-					 * It's possible we've reached the max poll fd allowed.
-					 * Let's close the socket but continue normal execution.
-					 */
-					ret = close(sock);
-					if (ret) {
-						PERROR("close notify socket %d", sock);
-					}
-					lttng_fd_put(LTTNG_FD_APPS, 1);
-					continue;
-				}
-				DBG3("UST thread notify added sock %d to pollset", sock);
 			} else {
 				/*
 				 * At this point, we know that a registered application
 				 * triggered the event.
 				 */
-				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+				if (revents & (LPOLLIN | LPOLLPRI)) {
+					ret = ust_app_recv_notify(pollfd);
+					if (ret < 0) {
+						/* Removing from the poll set */
+						ret = lttng_poll_del(&events, pollfd);
+						if (ret < 0) {
+							goto error;
+						}
+
+						/* The socket is closed after a grace period here. */
+						ust_app_notify_sock_unregister(pollfd);
+					}
+				} else if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 					/* Removing from the poll set */
 					ret = lttng_poll_del(&events, pollfd);
 					if (ret < 0) {
@@ -156,22 +168,9 @@ restart:
 
 					/* The socket is closed after a grace period here. */
 					ust_app_notify_sock_unregister(pollfd);
-				} else if (revents & (LPOLLIN | LPOLLPRI)) {
-					ret = ust_app_recv_notify(pollfd);
-					if (ret < 0) {
-						/*
-						 * If the notification failed either the application is
-						 * dead or an internal error happened. In both cases,
-						 * we can only continue here. If the application is
-						 * dead, an unregistration will follow or else the
-						 * application will notice that we are not responding
-						 * on that socket and will close it.
-						 */
-						continue;
-					}
 				} else {
-					ERR("Unknown poll events %u for sock %d", revents, pollfd);
-					continue;
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto error;
 				}
 				health_code_update();
 			}
diff --git a/src/common/consumer.c b/src/common/consumer.c
index c34f47c..c8628e8 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -2240,26 +2240,22 @@ restart:
 			}
 
 			if (pollfd == lttng_pipe_get_readfd(ctx->consumer_metadata_pipe)) {
-				if (revents & (LPOLLERR | LPOLLHUP )) {
-					DBG("Metadata thread pipe hung up");
-					/*
-					 * Remove the pipe from the poll set and continue the loop
-					 * since their might be data to consume.
-					 */
-					lttng_poll_del(&events,
-							lttng_pipe_get_readfd(ctx->consumer_metadata_pipe));
-					lttng_pipe_read_close(ctx->consumer_metadata_pipe);
-					continue;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					ssize_t pipe_len;
 
 					pipe_len = lttng_pipe_read(ctx->consumer_metadata_pipe,
 							&stream, sizeof(stream));
 					if (pipe_len < sizeof(stream)) {
-						PERROR("read metadata stream");
+						if (pipe_len < 0) {
+							PERROR("read metadata stream");
+						}
 						/*
-						 * Continue here to handle the rest of the streams.
+						 * Remove the pipe from the poll set and continue the loop
+						 * since their might be data to consume.
 						 */
+						lttng_poll_del(&events,
+								lttng_pipe_get_readfd(ctx->consumer_metadata_pipe));
+						lttng_pipe_read_close(ctx->consumer_metadata_pipe);
 						continue;
 					}
 
@@ -2276,6 +2272,19 @@ restart:
 					/* Add metadata stream to the global poll events list */
 					lttng_poll_add(&events, stream->wait_fd,
 							LPOLLIN | LPOLLPRI | LPOLLHUP);
+				} else if (revents & (LPOLLERR | LPOLLHUP)) {
+					DBG("Metadata thread pipe hung up");
+					/*
+					 * Remove the pipe from the poll set and continue the loop
+					 * since their might be data to consume.
+					 */
+					lttng_poll_del(&events,
+							lttng_pipe_get_readfd(ctx->consumer_metadata_pipe));
+					lttng_pipe_read_close(ctx->consumer_metadata_pipe);
+					continue;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto end;
 				}
 
 				/* Handle other stream */
@@ -2294,8 +2303,30 @@ restart:
 			stream = caa_container_of(node, struct lttng_consumer_stream,
 					node);
 
-			/* Check for error event */
-			if (revents & (LPOLLERR | LPOLLHUP)) {
+			if (revents & (LPOLLIN | LPOLLPRI)) {
+				/* Get the data out of the metadata file descriptor */
+				DBG("Metadata available on fd %d", pollfd);
+				assert(stream->wait_fd == pollfd);
+
+				do {
+					health_code_update();
+
+					len = ctx->on_buffer_ready(stream, ctx);
+					/*
+					 * We don't check the return value here since if we get
+					 * a negative len, it means an error occured thus we
+					 * simply remove it from the poll set and free the
+					 * stream.
+					 */
+				} while (len > 0);
+
+				/* It's ok to have an unavailable sub-buffer */
+				if (len < 0 && len != -EAGAIN && len != -ENODATA) {
+					/* Clean up stream from consumer and free it. */
+					lttng_poll_del(&events, stream->wait_fd);
+					consumer_del_metadata_stream(stream, metadata_ht);
+				}
+			} else if (revents & (LPOLLERR | LPOLLHUP)) {
 				DBG("Metadata fd %d is hup|err.", pollfd);
 				if (!stream->hangup_flush_done
 						&& (consumer_data.type == LTTNG_CONSUMER32_UST
@@ -2323,31 +2354,11 @@ restart:
 				 * and securely free the stream.
 				 */
 				consumer_del_metadata_stream(stream, metadata_ht);
-			} else if (revents & (LPOLLIN | LPOLLPRI)) {
-				/* Get the data out of the metadata file descriptor */
-				DBG("Metadata available on fd %d", pollfd);
-				assert(stream->wait_fd == pollfd);
-
-				do {
-					health_code_update();
-
-					len = ctx->on_buffer_ready(stream, ctx);
-					/*
-					 * We don't check the return value here since if we get
-					 * a negative len, it means an error occured thus we
-					 * simply remove it from the poll set and free the
-					 * stream.
-					 */
-				} while (len > 0);
-
-				/* It's ok to have an unavailable sub-buffer */
-				if (len < 0 && len != -EAGAIN && len != -ENODATA) {
-					/* Clean up stream from consumer and free it. */
-					lttng_poll_del(&events, stream->wait_fd);
-					consumer_del_metadata_stream(stream, metadata_ht);
-				}
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				rcu_read_unlock;
+				goto end;
 			}
-
 			/* Release RCU lock for the stream looked up */
 			rcu_read_unlock();
 		}
@@ -2812,21 +2823,16 @@ restart:
 			}
 
 			if (pollfd == ctx->consumer_channel_pipe[0]) {
-				if (revents & (LPOLLERR | LPOLLHUP)) {
-					DBG("Channel thread pipe hung up");
-					/*
-					 * Remove the pipe from the poll set and continue the loop
-					 * since their might be data to consume.
-					 */
-					lttng_poll_del(&events, ctx->consumer_channel_pipe[0]);
-					continue;
-				} else if (revents & LPOLLIN) {
+				if (revents & LPOLLIN) {
 					enum consumer_channel_action action;
 					uint64_t key;
 
 					ret = read_channel_pipe(ctx, &chan, &key, &action);
 					if (ret <= 0) {
-						ERR("Error reading channel pipe");
+						if (ret < 0) {
+							ERR("Error reading channel pipe");
+						}
+						lttng_poll_del(&events, ctx->consumer_channel_pipe[0]);
 						continue;
 					}
 
@@ -2843,7 +2849,7 @@ restart:
 						rcu_read_unlock();
 						/* Add channel to the global poll events list */
 						lttng_poll_add(&events, chan->wait_fd,
-								LPOLLIN | LPOLLPRI);
+								LPOLLERR | LPOLLHUP);
 						break;
 					case CONSUMER_CHANNEL_DEL:
 					{
@@ -2903,6 +2909,17 @@ restart:
 						ERR("Unknown action");
 						break;
 					}
+				} else if (revents & (LPOLLERR | LPOLLHUP)) {
+					DBG("Channel thread pipe hung up");
+					/*
+					 * Remove the pipe from the poll set and continue the loop
+					 * since their might be data to consume.
+					 */
+					lttng_poll_del(&events, ctx->consumer_channel_pipe[0]);
+					continue;
+				} else {
+					ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+					goto end;
 				}
 
 				/* Handle other stream */
@@ -2941,6 +2958,10 @@ restart:
 						&& !uatomic_read(&chan->nb_init_stream_left)) {
 					consumer_del_channel(chan);
 				}
+			} else {
+				ERR("Unexpected poll events %u for sock %d", revents, pollfd);
+				rcu_read_unlock();
+				goto end;
 			}
 
 			/* Release RCU lock for the channel looked up */
-- 
2.1.4
