From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [MI RFC 2/3] Mi: support for command list
Date: Sun, 6 Apr 2014 15:30:57 -0400
Message-ID: <20140406193057.GA25250__721.443180418824$1396812885$gmane$org@psrcode-MS-7693>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1WWsmX-0001l3-9v
 for lttng-dev@lists.lttng.org; Sun, 06 Apr 2014 15:31:09 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so5368679qge.16
 for <lttng-dev@lists.lttng.org>; Sun, 06 Apr 2014 12:30:59 -0700 (PDT)
Received: from psrcode-MS-7693 (cable-28.246.173-253.electronicbox.net.
 [173.246.28.253])
 by mx.google.com with ESMTPSA id n7sm29831092qav.31.2014.04.06.12.30.58
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sun, 06 Apr 2014 12:30:59 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
---
 src/bin/lttng/commands/list.c | 888 ++++++++++++++++++++++++++++++++++++------
 src/common/mi-lttng.c         | 685 +++++++++++++++++++++++++++++++-
 src/common/mi-lttng.h         | 299 +++++++++++++-
 3 files changed, 1735 insertions(+), 137 deletions(-)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index bbd674c..a0d0e4c 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -23,6 +23,8 @@
 #include <string.h>
 #include <assert.h>
 
+#include <common/mi-lttng.h>
+
 #include "../command.h"
 
 static int opt_userspace;
@@ -48,6 +50,7 @@ enum {
 };
 
 static struct lttng_handle *handle;
+static struct mi_writer *writer;
 
 static struct poptOption long_options[] = {
 	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
@@ -148,89 +151,6 @@ static const char *snapshot_string(int value)
 	}
 }
 
-static
-const char *enabled_string(int value)
-{
-	switch (value) {
-	case 0:	return " [disabled]";
-	case 1: return " [enabled]";
-	case -1: return "";
-	default: return NULL;
-	}
-}
-
-static
-const char *filter_string(int value)
-{
-	switch (value) {
-	case 1:	return " [with filter]";
-	default: return "";
-	}
-}
-
-static
-const char *exclusion_string(int value)
-{
-	switch (value) {
-	case 1: return " [has exclusions]";
-	default: return "";
-	}
-}
-
-static const char *loglevel_string(int value)
-{
-	switch (value) {
-	case -1:
-		return "";
-	case LTTNG_LOGLEVEL_EMERG:
-		return "TRACE_EMERG";
-	case LTTNG_LOGLEVEL_ALERT:
-		return "TRACE_ALERT";
-	case LTTNG_LOGLEVEL_CRIT:
-		return "TRACE_CRIT";
-	case LTTNG_LOGLEVEL_ERR:
-		return "TRACE_ERR";
-	case LTTNG_LOGLEVEL_WARNING:
-		return "TRACE_WARNING";
-	case LTTNG_LOGLEVEL_NOTICE:
-		return "TRACE_NOTICE";
-	case LTTNG_LOGLEVEL_INFO:
-		return "TRACE_INFO";
-	case LTTNG_LOGLEVEL_DEBUG_SYSTEM:
-		return "TRACE_DEBUG_SYSTEM";
-	case LTTNG_LOGLEVEL_DEBUG_PROGRAM:
-		return "TRACE_DEBUG_PROGRAM";
-	case LTTNG_LOGLEVEL_DEBUG_PROCESS:
-		return "TRACE_DEBUG_PROCESS";
-	case LTTNG_LOGLEVEL_DEBUG_MODULE:
-		return "TRACE_DEBUG_MODULE";
-	case LTTNG_LOGLEVEL_DEBUG_UNIT:
-		return "TRACE_DEBUG_UNIT";
-	case LTTNG_LOGLEVEL_DEBUG_FUNCTION:
-		return "TRACE_DEBUG_FUNCTION";
-	case LTTNG_LOGLEVEL_DEBUG_LINE:
-		return "TRACE_DEBUG_LINE";
-	case LTTNG_LOGLEVEL_DEBUG:
-		return "TRACE_DEBUG";
-	default:
-		return "<<UNKNOWN>>";
-	}
-}
-
-static const char *logleveltype_string(enum lttng_loglevel_type value)
-{
-	switch (value) {
-	case LTTNG_EVENT_LOGLEVEL_ALL:
-		return ":";
-	case LTTNG_EVENT_LOGLEVEL_RANGE:
-		return " <=";
-	case LTTNG_EVENT_LOGLEVEL_SINGLE:
-		return " ==";
-	default:
-		return " <<TYPE UNKN>>";
-	}
-}
-
 /*
  * Pretty print single event.
  */
@@ -446,6 +366,118 @@ error:
 }
 
 /*
+ * Machine interface
+ * Ask session daemon for all user space tracepoints available and print them
+ *
+ * print_domain 0-> do not print domains and domain element
+ *                  (used when mi_list_jul_ust_events is nested under a domain)
+ *              else print the domains and domain element
+ */
+static int mi_list_jul_ust_events(enum lttng_domain_type type, int print_domain)
+{
+	int ret, i, size;
+	struct lttng_domain domain;
+	struct lttng_handle *handle;
+	struct lttng_event *event_list;
+	pid_t cur_pid = 0;
+	char *cmdline = NULL;
+	int pid_element_open = 0;
+
+	memset(&domain, 0, sizeof(domain));
+
+	domain.type = type;
+
+	handle = lttng_create_handle(NULL, &domain);
+	if (handle == NULL) {
+		ret = -LTTNG_ERR_NOMEM;
+		goto end;
+	}
+
+	size = lttng_list_tracepoints(handle, &event_list);
+	if (size < 0) {
+		if (LTTNG_DOMAIN_UST) {
+			ERR("Unable to list UST events: %s", lttng_strerror(size));
+		} else if (LTTNG_DOMAIN_JUL) {
+			ERR("Unable to list JUL events: %s", lttng_strerror(size));
+		}
+		lttng_destroy_handle(handle);
+		return size;
+	}
+
+	if (print_domain) {
+		/* Open domains element */
+		ret = mi_lttng_domains_open(writer);
+		if (ret) {
+			goto end;
+		}
+
+		/* Write domain */
+		ret = mi_lttng_domain(writer, &domain, 1);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* Open pids element */
+	ret = mi_lttng_pids_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	for (i = 0; i < size; i++) {
+		if (cur_pid != event_list[i].pid) {
+			if (pid_element_open) {
+				/* Close the previous envents and  pid element */
+				ret = mi_lttng_close_multi_element(writer, 2);
+				if (ret) {
+					goto end;
+				}
+				pid_element_open = !pid_element_open;
+			}
+
+			cur_pid = event_list[i].pid;
+			cmdline = get_cmdline_by_pid(cur_pid);
+
+			if (!pid_element_open) {
+				/* Open and write a pid elemen */
+				ret = mi_lttng_pid(writer, cur_pid, cmdline, 1);
+				if (ret) {
+					goto end;
+				}
+
+				/* Open events element */
+				ret = mi_lttng_events_open(writer);
+				if (ret) {
+					goto end;
+				}
+
+				pid_element_open = !pid_element_open;
+			}
+			free(cmdline);
+		}
+
+		/* Write an event */
+		ret = mi_lttng_event(writer, &event_list[i], 0);
+		if (ret) {
+			goto end;
+		}
+	}
+
+
+	/* Close pids */
+	ret = mi_lttng_writer_close_element(writer);
+
+	if (print_domain) {
+		/* Close domain, domains */
+		ret = mi_lttng_close_multi_element(writer, 2);
+	}
+end:
+	free(event_list);
+	lttng_destroy_handle(handle);
+	return ret;
+}
+
+/*
  * Ask session daemon for all user space tracepoint fields available.
  */
 static int list_ust_event_fields(void)
@@ -514,6 +546,144 @@ error:
 }
 
 /*
+ * Machine interface
+ * List all ust event with their fields
+ */
+static int mi_list_ust_event_fields(void)
+{
+	int ret, i, size;
+	struct lttng_domain domain;
+	struct lttng_handle *handle;
+	struct lttng_event_field *event_field_list;
+	pid_t cur_pid = 0;
+	char *cmdline = NULL;
+	int pid_element_open = 0;
+	int event_element_open = 0;
+
+	struct lttng_event cur_event;
+
+	memset(&domain, 0, sizeof(domain));
+	memset(&cur_event, 0, sizeof(cur_event));
+
+	domain.type = LTTNG_DOMAIN_UST;
+
+	handle = lttng_create_handle(NULL, &domain);
+	if (handle == NULL) {
+		ret = -LTTNG_ERR_NOMEM;
+		goto end;
+	}
+
+	size = lttng_list_tracepoint_fields(handle, &event_field_list);
+	if (size < 0) {
+		ERR("Unable to list UST event fields: %s", lttng_strerror(size));
+		lttng_destroy_handle(handle);
+		return size;
+	}
+
+	/* Open domains element */
+	ret = mi_lttng_domains_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	/* Write domain */
+	ret = mi_lttng_domain(writer, &domain, 1);
+
+	/* Open pids element */
+	ret = mi_lttng_pids_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+
+	for (i = 0; i < size; i++) {
+		if (cur_pid != event_field_list[i].event.pid) {
+			if (pid_element_open) {
+				if (event_element_open) {
+					/* Close the previous fields element
+					 * and the previous event
+					 */
+					ret = mi_lttng_close_multi_element(writer, 2);
+					if (ret) {
+						goto end;
+					}
+					event_element_open = !event_element_open ;
+				}
+				/* Close the previous events, pid element */
+				ret = mi_lttng_close_multi_element(writer, 2);
+				if (ret) {
+					goto end;
+				}
+				pid_element_open = !pid_element_open;
+			}
+
+			cur_pid = event_field_list[i].event.pid;
+			cmdline = get_cmdline_by_pid(cur_pid);
+			if (!pid_element_open) {
+				/* Open and write a pid elemen */
+				ret = mi_lttng_pid(writer, cur_pid, cmdline, 1);
+				if (ret) {
+					goto end;
+				}
+
+				/* Open events element */
+				ret = mi_lttng_events_open(writer);
+				if (ret) {
+					goto end;
+				}
+				pid_element_open = !pid_element_open;
+			}
+			free(cmdline);
+			/* Wipe current event since we are about to print a new PID. */
+			memset(&cur_event, 0, sizeof(cur_event));
+		}
+
+		if (strcmp(cur_event.name, event_field_list[i].event.name) != 0) {
+			if (event_element_open) {
+				/* Close the previous fields element and the previous event */
+				ret = mi_lttng_close_multi_element(writer, 2);
+				if (ret) {
+					goto end;
+				}
+				event_element_open = !event_element_open ;
+			}
+
+			memcpy(&cur_event, &event_field_list[i].event,
+					sizeof(cur_event));
+
+			if (!event_element_open) {
+				/* Open and write the event */
+				ret = mi_lttng_event(writer, &cur_event, 1);
+				if (ret) {
+					goto end;
+				}
+
+				/* Open a fields element */
+				ret = mi_lttng_event_fields_open(writer);
+				if (ret) {
+					goto end;
+				}
+				event_element_open = !event_element_open ;
+			}
+		}
+
+		/* Print the event_field */
+		ret = mi_lttng_event_field(writer, &event_field_list[i]);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* Close pids, domain, domains */
+	ret = mi_lttng_close_multi_element(writer, 3);
+
+end:
+	free(event_field_list);
+	lttng_destroy_handle(handle);
+	return ret;
+}
+
+/*
  * Ask for all trace events in the kernel and pretty print them.
  */
 static int list_kernel_events(void)
@@ -560,6 +730,71 @@ error:
 }
 
 /*
+ * Machine interface
+ * Ask for all trace events in the kernel
+ */
+static int mi_list_kernel_events(void)
+{
+	int ret, i, size;
+	struct lttng_domain domain;
+	struct lttng_handle *handle;
+	struct lttng_event *event_list;
+
+	memset(&domain, 0, sizeof(domain));
+
+	domain.type = LTTNG_DOMAIN_KERNEL;
+
+	handle = lttng_create_handle(NULL, &domain);
+	if (handle == NULL) {
+		ret = -LTTNG_ERR_NOMEM;
+		goto end;
+	}
+
+	size = lttng_list_tracepoints(handle, &event_list);
+	if (size < 0) {
+		ERR("Unable to list kernel events: %s", lttng_strerror(size));
+		lttng_destroy_handle(handle);
+		return size;
+	}
+
+	/* Open domains element */
+	ret = mi_lttng_domains_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	/* Write domain */
+	ret = mi_lttng_domain(writer, &domain, 1);
+	if (ret) {
+		goto end;
+	}
+
+	/* Open events */
+	ret = mi_lttng_events_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	for (i = 0; i < size; i++) {
+		mi_lttng_event(writer, &event_list[i], 0);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* close events, domain and domains */
+	ret = mi_lttng_close_multi_element(writer, 3);
+	if (ret) {
+		goto end;
+	}
+
+end:
+	free(event_list);
+	lttng_destroy_handle(handle);
+	return ret;
+}
+
+/*
  * List JUL events for a specific session using the handle.
  *
  * Return CMD_SUCCESS on success else a negative value.
@@ -598,6 +833,43 @@ error:
 }
 
 /*
+ * Machine Interface
+ * List JUL events for a specific session using the handle.
+ */
+static int mi_list_session_jul_events(void)
+{
+	int ret, count, i;
+	struct lttng_event *events = NULL;
+
+	count = lttng_list_events(handle, "", &events);
+	if (count < 0) {
+		ret = count;
+		ERR("%s", lttng_strerror(ret));
+		goto end;
+	}
+
+	/* Open events element */
+	ret = mi_lttng_events_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	for (i = 0; i < count; i++) {
+		ret = mi_lttng_event(writer, &events[i], 0);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* Close events element */
+	ret = mi_lttng_writer_close_element(writer);
+
+end:
+	free(events);
+	return ret;
+}
+
+/*
  * List events of channel of session and domain.
  */
 static int list_events(const char *channel_name)
@@ -633,6 +905,43 @@ error:
 }
 
 /*
+ * Machine interface
+ * List events of channel of session and domain.
+ */
+static int mi_list_events(const char *channel_name)
+{
+	int ret, count, i;
+	struct lttng_event *events = NULL;
+
+	count = lttng_list_events(handle, channel_name, &events);
+	if (count < 0) {
+		ret = count;
+		ERR("%s", lttng_strerror(ret));
+		goto end;
+	}
+
+	/* Open events element */
+	ret = mi_lttng_events_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	for (i = 0; i < count; i++) {
+		ret = mi_lttng_event(writer, &events[i], 0);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* Close events element */
+	ret = mi_lttng_writer_close_element(writer);
+
+end:
+	free(events);
+	return ret;
+}
+
+/*
  * Pretty print channel
  */
 static void print_channel(struct lttng_channel *channel)
@@ -724,13 +1033,92 @@ error_channels:
 }
 
 /*
+ * Machine interface
+ * List channel(s) of session and domain.
+ *
+ * If channel_name is NULL, all channels are listed.
+ */
+static int mi_list_channels(const char *channel_name)
+{
+	int count, i, ret;
+	unsigned int chan_found = 0;
+	struct lttng_channel *channels = NULL;
+
+	count = lttng_list_channels(handle, &channels);
+	if (count < 0) {
+		switch (-count) {
+		case LTTNG_ERR_KERN_CHAN_NOT_FOUND:
+			/* When printing mi this is not an error
+			 * but an empty channels element */
+			count = 0;
+			break;
+		default:
+			/* We had a real error */
+			ret = count;
+			ERR("%s", lttng_strerror(ret));
+			goto error_channels;
+			break;
+		}
+	}
+
+	/* Open channels element */
+	ret = mi_lttng_channels_open(writer);
+	if (ret) {
+		goto error;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (channel_name != NULL) {
+			if (strncmp(channels[i].name, channel_name, NAME_MAX) == 0) {
+				chan_found = 1;
+			} else {
+				continue;
+			}
+		}
+
+		/* Write channel element  and leave it open */
+		ret = mi_lttng_channel(writer, &channels[i], 1);
+
+		/* Listing events per channel */
+		ret = mi_list_events(channels[i].name);
+		if (ret) {
+			goto error;
+		}
+
+		/* Closing the channel element we opened earlier */
+		ret = mi_lttng_writer_close_element(writer);
+		if (ret) {
+			goto error;
+		}
+
+		if (chan_found) {
+			break;
+		}
+	}
+
+	/* Close channels element */
+	ret = mi_lttng_writer_close_element(writer);
+	if (ret) {
+		goto error;
+	}
+
+
+error:
+	free(channels);
+
+error_channels:
+	return ret;
+}
+
+/*
  * List available tracing session. List only basic information.
  *
  * If session_name is NULL, all sessions are listed.
  */
 static int list_sessions(const char *session_name)
 {
-	int ret, count, i;
+	int ret = CMD_SUCCESS;
+	int count, i;
 	unsigned int session_found = 0;
 	struct lttng_session *sessions;
 
@@ -749,25 +1137,25 @@ static int list_sessions(const char *session_name)
 		MSG("Available tracing sessions:");
 	}
 
+
 	for (i = 0; i < count; i++) {
 		if (session_name != NULL) {
 			if (strncmp(sessions[i].name, session_name, NAME_MAX) == 0) {
 				session_found = 1;
-				MSG("Tracing session %s: [%s%s]", session_name,
-						active_string(sessions[i].enabled),
-						snapshot_string(sessions[i].snapshot_mode));
-				MSG("%sTrace path: %s\n", indent4, sessions[i].path);
+					MSG("Tracing session %s: [%s%s]", session_name,
+							active_string(sessions[i].enabled),
+							snapshot_string(sessions[i].snapshot_mode));
+					MSG("%sTrace path: %s\n", indent4, sessions[i].path);
 				break;
 			}
 		} else {
-			MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name, sessions[i].path,
-					active_string(sessions[i].enabled),
-					snapshot_string(sessions[i].snapshot_mode));
+				MSG("  %d) %s (%s) [%s%s]", i + 1,
+						sessions[i].name, sessions[i].path,
+						active_string(sessions[i].enabled),
+						snapshot_string(sessions[i].snapshot_mode));
 		}
 	}
 
-	free(sessions);
-
 	if (!session_found && session_name != NULL) {
 		ERR("Session '%s' not found", session_name);
 		ret = CMD_ERROR;
@@ -778,10 +1166,97 @@ static int list_sessions(const char *session_name)
 		MSG("\nUse lttng list <session_name> for more details");
 	}
 
+error:
+	free(sessions);
 end:
-	return CMD_SUCCESS;
+	return ret;
+}
 
-error:
+/*
+ * Machine interface
+ * Find the session with session_name as name
+ * and print his informations.
+ */
+static int mi_list_session(const char *session_name)
+{
+	int ret, count, i;
+	struct lttng_session *sessions;
+	unsigned int session_found = 0;
+
+	count = lttng_list_sessions(&sessions);
+	if (count < 0) {
+		ret = count;
+		ERR("%s", lttng_strerror(ret));
+		goto end;
+	}
+
+	if (session_name == NULL) {
+		ret = -LTTNG_ERR_SESS_NOT_FOUND;
+		goto end;
+	}
+
+	for (i = 0; i < count; i++) {
+			if (strncmp(sessions[i].name, session_name, NAME_MAX) == 0) {
+				/* We need to left it unclosed to append other informations
+				 * like domain, channel, events etc.*/
+				session_found = 1;
+				ret = mi_lttng_session(writer, &sessions[i], 1);
+				if (ret) {
+					goto end;
+				}
+				break;
+			}
+	}
+
+	if (!session_found) {
+		ERR("Session not found");
+		ret = -LTTNG_ERR_SESS_NOT_FOUND;
+		goto end;
+	}
+
+end:
+	free(sessions);
+	return ret;
+}
+
+/*
+ * Machine interface
+ * List all availables session
+ */
+static int mi_list_sessions()
+{
+	int ret, count, i;
+	struct lttng_session *sessions;
+
+	count = lttng_list_sessions(&sessions);
+	if (count < 0) {
+		ret = count;
+		ERR("%s", lttng_strerror(ret));
+		goto end;
+	}
+
+	/* Opening sessions element */
+	ret = mi_lttng_sessions_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	/* Listing sessions */
+	for (i = 0; i < count; i++) {
+		ret = mi_lttng_session(writer, &sessions[i], 0);
+		if (ret) {
+			goto end;
+		}
+	}
+
+	/* Closing sessions element */
+	ret = mi_lttng_writer_close_element(writer);
+	if (ret) {
+		goto end;
+	}
+
+end:
+	free(sessions);
 	return ret;
 }
 
@@ -829,6 +1304,39 @@ error:
 }
 
 /*
+ * Machine Interface
+ * list available domain(s) for a session.
+ */
+static int mi_list_domains(const char *session_name)
+{
+	int i, count, ret;
+	struct lttng_domain *domains = NULL;
+
+	/* Open domains element */
+	ret = mi_lttng_domains_open(writer);
+	if (ret) {
+		goto end;
+	}
+
+	count = lttng_list_domains(session_name, &domains);
+	if (count < 0) {
+		ret = count;
+		ERR("%s", lttng_strerror(ret));
+		goto end;
+	}
+
+	for (i = 0; i < count; i++) {
+		ret = mi_lttng_domain(writer, &domains[i] , 0);
+	}
+
+	/* Closing domains element */
+	ret = mi_lttng_writer_close_element(writer);
+end:
+	free(domains);
+	return ret;
+}
+
+/*
  * The 'list <options>' first level command
  */
 int cmd_list(int argc, const char **argv)
@@ -850,13 +1358,6 @@ int cmd_list(int argc, const char **argv)
 	pc = poptGetContext(NULL, argc, argv, long_options, 0);
 	poptReadDefaultConfig(pc, 0);
 
-	/* TODO: mi support */
-	if (lttng_opt_mi) {
-		ret = -LTTNG_ERR_MI_NOT_IMPLEMENTED;
-		ERR("mi option not supported");
-		goto end;
-	}
-
 	while ((opt = poptGetNextOpt(pc)) != -1) {
 		switch (opt) {
 		case OPT_HELP:
@@ -875,6 +1376,29 @@ int cmd_list(int argc, const char **argv)
 		}
 	}
 
+	/* Mi check */
+	if (lttng_opt_mi) {
+		writer = mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
+		if (!writer) {
+			ret = -LTTNG_ERR_NOMEM;
+			goto end;
+		}
+
+		/* Open command element */
+		ret = mi_lttng_writer_command_open(writer,
+				mi_lttng_element_command_list);
+		if (ret) {
+			goto end;
+		}
+
+		/* Open output element */
+		ret = mi_lttng_writer_open_element(writer,
+				mi_lttng_element_command_output);
+		if (ret) {
+			goto end;
+		}
+	}
+
 	/* Get session name (trailing argument) */
 	session_name = poptGetArg(pc);
 	DBG2("Session name: %s", session_name);
@@ -899,53 +1423,111 @@ int cmd_list(int argc, const char **argv)
 
 	if (session_name == NULL) {
 		if (!opt_kernel && !opt_userspace && !opt_jul) {
-			ret = list_sessions(NULL);
-			if (ret != 0) {
+			if (lttng_opt_mi) {
+				ret = mi_list_sessions();
+			} else {
+				ret = list_sessions(NULL);
+			}
+			if (ret) {
 				goto end;
 			}
 		}
 		if (opt_kernel) {
-			ret = list_kernel_events();
-			if (ret < 0) {
-				ret = CMD_ERROR;
+			if (lttng_opt_mi) {
+				ret = mi_list_kernel_events();
+			} else {
+				ret = list_kernel_events();
+			}
+			if (ret) {
 				goto end;
 			}
 		}
 		if (opt_userspace) {
 			if (opt_fields) {
-				ret = list_ust_event_fields();
+				if (lttng_opt_mi) {
+					ret = mi_list_ust_event_fields();
+				} else {
+					ret = list_ust_event_fields();
+				}
 			} else {
-				ret = list_ust_events();
+				if (lttng_opt_mi) {
+					ret = mi_list_jul_ust_events(LTTNG_DOMAIN_UST, 1);
+				} else {
+					ret = list_ust_events();
+				}
 			}
-			if (ret < 0) {
-				ret = CMD_ERROR;
+			if (ret) {
 				goto end;
 			}
 		}
 		if (opt_jul) {
-			ret = list_jul_events();
-			if (ret < 0) {
-				ret = CMD_ERROR;
+			if (lttng_opt_mi) {
+				ret = mi_list_jul_ust_events(LTTNG_DOMAIN_JUL, 1);
+			} else {
+				ret = list_jul_events();
+			}
+			if (ret) {
 				goto end;
 			}
 		}
 	} else {
 		/* List session attributes */
-		ret = list_sessions(session_name);
-		if (ret != 0) {
+		if (lttng_opt_mi) {
+			/* Open element sessions
+			 * Present for xml consistency */
+			ret = mi_lttng_sessions_open(writer);
+			if (ret) {
+				goto end;
+			}
+
+			/* MI: the ouptut of list_sessions is an unclosed session element */
+			ret = mi_list_session(session_name);
+		} else {
+			ret = list_sessions(session_name);
+		}
+		if (ret) {
 			goto end;
 		}
 
 		/* Domain listing */
 		if (opt_domain) {
-			ret = list_domains(session_name);
+			if (lttng_opt_mi) {
+				ret = mi_list_domains(session_name);
+			} else {
+				ret = list_domains(session_name);
+			}
 			goto end;
 		}
 
+		/* Channel listing */
 		if (opt_kernel || opt_userspace) {
-			/* Channel listing */
-			ret = list_channels(opt_channel);
-			if (ret < 0) {
+			if (lttng_opt_mi) {
+				/* Add of domains and domain element for xml
+				 * consistency and validation
+				 */
+				ret = mi_lttng_domains_open(writer);
+				if (ret) {
+					goto end;
+				}
+
+				/* Open domain and leave it open for
+				 * nested channels printing */
+				ret = mi_lttng_domain(writer, &domain, 1);
+				if (ret) {
+					goto end;
+				}
+
+				ret = mi_list_channels(opt_channel);
+				if (ret) {
+					goto end;
+				}
+
+				/* Close domain and domain element */
+				ret = mi_lttng_close_multi_element(writer, 2);
+			} else {
+				ret = list_channels(opt_channel);
+			}
+			if (ret) {
 				goto end;
 			}
 		} else {
@@ -959,6 +1541,13 @@ int cmd_list(int argc, const char **argv)
 				goto end;
 			}
 
+			if (lttng_opt_mi) {
+				ret = mi_lttng_domains_open(writer);
+				if (ret) {
+					goto end;
+				}
+			}
+
 			for (i = 0; i < nb_domain; i++) {
 				switch (domains[i].type) {
 				case LTTNG_DOMAIN_KERNEL:
@@ -978,6 +1567,13 @@ int cmd_list(int argc, const char **argv)
 					break;
 				}
 
+				if (lttng_opt_mi) {
+					ret = mi_lttng_domain(writer, &domains[i], 1);
+					if (ret) {
+						goto end;
+					}
+				}
+
 				/* Clean handle before creating a new one */
 				if (handle) {
 					lttng_destroy_handle(handle);
@@ -990,22 +1586,66 @@ int cmd_list(int argc, const char **argv)
 				}
 
 				if (domains[i].type == LTTNG_DOMAIN_JUL) {
-					ret = list_session_jul_events();
-					if (ret < 0) {
+					if (lttng_opt_mi) {
+						ret = mi_list_session_jul_events();
+					} else {
+						ret = list_session_jul_events();
+					}
+					if (ret) {
 						goto end;
 					}
 					continue;
 				}
 
-				ret = list_channels(opt_channel);
-				if (ret < 0) {
+				if (lttng_opt_mi) {
+					ret = mi_list_channels(opt_channel);
+				} else {
+					ret = list_channels(opt_channel);
+				}
+				if (ret) {
+					goto end;
+				}
+
+				if (lttng_opt_mi) {
+					/* Close domain element */
+					ret = mi_lttng_writer_close_element(writer);
+					if (ret) {
+						goto end;
+					}
+				}
+
+			}
+			if (lttng_opt_mi) {
+				/* Close the domains, session and sessions element */
+				ret = mi_lttng_close_multi_element(writer, 3);
+				if (ret) {
 					goto end;
 				}
 			}
 		}
 	}
 
+	/* Mi closing */
+	if (lttng_opt_mi) {
+		/* Close  output element */
+		ret = mi_lttng_writer_close_element(writer);
+		if (ret) {
+			goto end;
+		}
+
+		/* Command element close */
+		ret = mi_lttng_writer_command_close(writer);
+		if (ret) {
+			goto end;
+		}
+	}
 end:
+	/* Mi clean-up */
+	if (writer && mi_lttng_writer_destroy(writer)) {
+		/* Preserve original error code */
+		ret = ret ? ret : LTTNG_ERR_MI_IO_FAIL;
+	}
+
 	free(domains);
 	if (handle) {
 		lttng_destroy_handle(handle);
diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
index bbec2c5..19af444 100644
--- a/src/common/mi-lttng.c
+++ b/src/common/mi-lttng.c
@@ -16,10 +16,13 @@
  * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+
 #include <include/config.h>
 #include <common/config/config.h>
 #include "mi-lttng.h"
 
+#include <assert.h>
+
 /* Strings related to command */
 const char * const mi_lttng_element_command = "command";
 const char * const mi_lttng_element_command_version = "version";
@@ -37,6 +40,159 @@ const char * const mi_lttng_element_version_license = "license";
 const char * const mi_lttng_element_version_patch_level = "patchLevel";
 const char * const mi_lttng_element_version_description = "description";
 
+/* Strings related to pid */
+const char * const mi_lttng_element_pids = "pids";
+const char * const mi_lttng_element_pid = "pid";
+const char * const mi_lttng_element_pid_id = "id";
+
+/* String related to a lttng_event_field */
+const char * const mi_lttng_element_event_field = "event_field";
+const char * const mi_lttng_element_event_fields = "event_fields";
+
+/* General elements of mi_lttng */
+const char * const mi_lttng_element_type_other = "OTHER";
+const char * const mi_lttng_element_type_integer = "INTEGER";
+const char * const mi_lttng_element_type_enum = "ENUM";
+const char * const mi_lttng_element_type_float = "FLOAT";
+const char * const mi_lttng_element_type_string = "STRING";
+const char * const mi_lttng_element_nowrite = "nowrite";
+
+const char * const mi_lttng_element_empty = "";
+
+const char *enabled_string(int value)
+{
+	switch (value) {
+	case 0:	return " [disabled]";
+	case 1: return " [enabled]";
+	case -1: return "";
+	default: return NULL;
+	}
+}
+
+const char *filter_string(int value)
+{
+	switch (value) {
+	case 1:	return " [with filter]";
+	default: return "";
+	}
+}
+
+const char *exclusion_string(int value)
+{
+	switch (value) {
+	case 1: return " [has exclusions]";
+	default: return "";
+	}
+}
+
+const char *loglevel_string(int value)
+{
+	switch (value) {
+	case -1:
+		return "";
+	case LTTNG_LOGLEVEL_EMERG:
+		return "TRACE_EMERG";
+	case LTTNG_LOGLEVEL_ALERT:
+		return "TRACE_ALERT";
+	case LTTNG_LOGLEVEL_CRIT:
+		return "TRACE_CRIT";
+	case LTTNG_LOGLEVEL_ERR:
+		return "TRACE_ERR";
+	case LTTNG_LOGLEVEL_WARNING:
+		return "TRACE_WARNING";
+	case LTTNG_LOGLEVEL_NOTICE:
+		return "TRACE_NOTICE";
+	case LTTNG_LOGLEVEL_INFO:
+		return "TRACE_INFO";
+	case LTTNG_LOGLEVEL_DEBUG_SYSTEM:
+		return "TRACE_DEBUG_SYSTEM";
+	case LTTNG_LOGLEVEL_DEBUG_PROGRAM:
+		return "TRACE_DEBUG_PROGRAM";
+	case LTTNG_LOGLEVEL_DEBUG_PROCESS:
+		return "TRACE_DEBUG_PROCESS";
+	case LTTNG_LOGLEVEL_DEBUG_MODULE:
+		return "TRACE_DEBUG_MODULE";
+	case LTTNG_LOGLEVEL_DEBUG_UNIT:
+		return "TRACE_DEBUG_UNIT";
+	case LTTNG_LOGLEVEL_DEBUG_FUNCTION:
+		return "TRACE_DEBUG_FUNCTION";
+	case LTTNG_LOGLEVEL_DEBUG_LINE:
+		return "TRACE_DEBUG_LINE";
+	case LTTNG_LOGLEVEL_DEBUG:
+		return "TRACE_DEBUG";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+const char *logleveltype_string(enum lttng_loglevel_type value)
+{
+	switch (value) {
+	case LTTNG_EVENT_LOGLEVEL_ALL:
+		return ":";
+	case LTTNG_EVENT_LOGLEVEL_RANGE:
+		return " <=";
+	case LTTNG_EVENT_LOGLEVEL_SINGLE:
+		return " ==";
+	default:
+		return " TYPE UNKN";
+	}
+}
+
+const char *eventtype_string(enum lttng_event_type value)
+{
+	switch (value) {
+	case LTTNG_EVENT_ALL:
+		return config_event_type_all;
+		break;
+	case LTTNG_EVENT_TRACEPOINT:
+		return config_event_type_tracepoint;
+		break;
+	case LTTNG_EVENT_PROBE:
+		return config_event_type_probe;
+		break;
+	case LTTNG_EVENT_FUNCTION:
+		return config_event_type_function;
+		break;
+	case LTTNG_EVENT_FUNCTION_ENTRY:
+		return config_event_type_function_entry;
+		break;
+	case LTTNG_EVENT_SYSCALL:
+		return config_event_type_syscall;
+		break;
+	case LTTNG_EVENT_NOOP:
+		return config_event_type_noop;
+		break;
+	default:
+		return mi_lttng_element_empty;
+		break;
+	}
+}
+
+const char *eventfieldtype_string(enum lttng_event_field_type val)
+{
+	const char *ret;
+
+	switch (val) {
+	case(LTTNG_EVENT_FIELD_INTEGER):
+		ret = mi_lttng_element_type_integer;
+		break;
+	case(LTTNG_EVENT_FIELD_ENUM):
+		ret = mi_lttng_element_type_enum;
+		break;
+	case(LTTNG_EVENT_FIELD_FLOAT):
+		ret = mi_lttng_element_type_float;
+		break;
+	case(LTTNG_EVENT_FIELD_STRING):
+		ret = mi_lttng_element_type_string;
+		break;
+	default:
+		ret = mi_lttng_element_type_other;
+		break;
+	}
+	return ret;
+}
+
 LTTNG_HIDDEN
 struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_type)
 {
@@ -119,6 +275,25 @@ int mi_lttng_writer_close_element(struct mi_writer *writer)
 }
 
 LTTNG_HIDDEN
+int mi_lttng_close_multi_element(struct mi_writer *writer,
+		unsigned int nb_element)
+{
+	int ret, i;
+	if (nb_element < 1) {
+		ret = 0;
+		goto end;
+	}
+	for (i = 0; i < nb_element; i++) {
+		ret = mi_lttng_writer_close_element(writer);
+		if (ret) {
+			goto end;
+		}
+	}
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
 int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writer,
 		const char *element_name, uint64_t value)
 {
@@ -226,12 +401,20 @@ end:
 }
 
 LTTNG_HIDDEN
+int mi_lttng_sessions_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, config_element_sessions);
+}
+
+LTTNG_HIDDEN
 int mi_lttng_session(struct mi_writer *writer,
 		struct lttng_session *session, int is_open)
 {
 	int ret;
 
-	/* open sessions element */
+	assert(session);
+
+	/* Open sessions element */
 	ret = mi_lttng_writer_open_element(writer,
 			config_element_session);
 	if (ret) {
@@ -245,28 +428,28 @@ int mi_lttng_session(struct mi_writer *writer,
 		goto end;
 	}
 
-	/* path */
+	/* Path */
 	ret = mi_lttng_writer_write_element_string(writer,
 			config_element_path, session->path);
 	if (ret) {
 		goto end;
 	}
 
-	/* enabled ? */
-	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+	/* Enabled ? */
+	ret = mi_lttng_writer_write_element_bool(writer,
 			config_element_enabled, session->enabled);
 	if (ret) {
 		goto end;
 	}
 
-	/* snapshot mode */
+	/* Snapshot mode */
 	ret = mi_lttng_writer_write_element_unsigned_int(writer,
 			config_element_snapshot_mode, session->snapshot_mode);
 	if (ret) {
 		goto end;
 	}
 
-	/* live timer interval in usec */
+	/* Live timer interval in usec */
 	ret = mi_lttng_writer_write_element_unsigned_int(writer,
 			config_element_live_timer_interval,
 			session->live_timer_interval);
@@ -282,3 +465,493 @@ end:
 	return ret;
 
 }
+
+LTTNG_HIDDEN
+int mi_lttng_domains_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, config_element_domains);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_domain(struct mi_writer *writer,
+		struct lttng_domain *domain, int is_open)
+{
+	int ret = 0;
+	const char *str_domain;
+	const char *str_buffer;
+
+	assert(domain);
+
+	/* Open domain element */
+	ret = mi_lttng_writer_open_element(writer, config_element_domain);
+	if (ret) {
+		goto end;
+	}
+
+	/* Type
+	 * Note: This is a *duplicate* of get_domain_str from bin/lttng/utils.c
+	 */
+	switch (domain->type) {
+	case LTTNG_DOMAIN_KERNEL:
+		str_domain = config_domain_type_kernel;
+		break;
+	case LTTNG_DOMAIN_UST:
+		str_domain = config_domain_type_ust;
+		break;
+	case LTTNG_DOMAIN_JUL:
+		str_domain = config_domain_type_jul;
+		break;
+	default:
+		/* Should not have an unknown domain */
+		assert(0);
+	}
+
+	ret = mi_lttng_writer_write_element_string(writer, config_element_type,
+			str_domain);
+	if (ret) {
+		goto end;
+	}
+
+	/* Buffer Type */
+	switch (domain->buf_type) {
+	case LTTNG_BUFFER_PER_PID:
+		str_buffer = config_buffer_type_per_pid;
+		break;
+	case LTTNG_BUFFER_PER_UID:
+		str_buffer = config_buffer_type_per_uid;
+		break;
+	case LTTNG_BUFFER_GLOBAL:
+		str_buffer = config_buffer_type_global;
+		break;
+	default:
+		/* Shoul not have an unknow buffer type */
+		assert(0);
+	}
+
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_buffer_type, str_buffer);
+	if (ret) {
+		goto end;
+	}
+
+	/* TODO: attr... not sure how to use the union.... */
+
+	if (!is_open) {
+		/* Closing domain element */
+		ret = mi_lttng_writer_close_element(writer);
+	}
+
+end:
+	return ret;
+
+}
+
+LTTNG_HIDDEN
+int mi_lttng_channels_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, config_element_channels);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_channel(struct mi_writer *writer,
+		struct lttng_channel *channel, int is_open)
+{
+	int ret = 0;
+
+	assert(channel);
+
+	/* Opening channel element */
+	ret = mi_lttng_writer_open_element(writer, config_element_channel);
+	if (ret) {
+		goto end;
+	}
+	/* Name */
+	ret = mi_lttng_writer_write_element_string(writer, config_element_name,
+			channel->name);
+	if (ret) {
+		goto end;
+	}
+
+	/* Enabled ? */
+	ret = mi_lttng_writer_write_element_bool(writer,
+			config_element_enabled, channel->enabled);
+	if (ret) {
+		goto end;
+	}
+
+	/* Attribute */
+	ret = mi_lttng_channel_attr(writer, &channel->attr);
+	if (ret) {
+		goto end;
+	}
+
+	if (!is_open) {
+		/* Closing channel element */
+		ret = mi_lttng_writer_close_element(writer);
+		if (ret) {
+			goto end;
+		}
+	}
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_channel_attr(struct mi_writer *writer,
+		struct lttng_channel_attr *attr)
+{
+	int ret = 0;
+
+	assert(attr);
+
+	/* Opening Attributes */
+	ret = mi_lttng_writer_open_element(writer, config_element_attributes);
+	if (ret) {
+		goto end;
+	}
+
+	/* Overwrite */
+	ret = mi_lttng_writer_write_element_string(writer,
+		config_element_overwrite_mode,
+		attr->overwrite ? config_overwrite_mode_overwrite :
+			config_overwrite_mode_discard);
+	if (ret) {
+		goto end;
+	}
+
+	/* Sub buffer size in byte */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_subbuf_size, attr->subbuf_size);
+	if (ret) {
+		goto end;
+	}
+
+	/* Number of sub buffer (power of two) */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_num_subbuf,
+		attr->num_subbuf);
+	if (ret) {
+		goto end;
+	}
+
+	/* Switch timer interval in usec */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_switch_timer_interval,
+		attr->switch_timer_interval);
+	if (ret) {
+		goto end;
+	}
+
+	/* Read timer interval in usec */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_read_timer_interval,
+		attr->read_timer_interval);
+	if (ret) {
+		goto end;
+	}
+
+	/* Event output */
+	ret = mi_lttng_writer_write_element_string(writer,
+		config_element_output_type,
+		attr->output == LTTNG_EVENT_SPLICE ?
+		config_output_type_splice : config_output_type_mmap);
+	if (ret) {
+		goto end;
+	}
+
+	/* Tracefile size in bytes */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_tracefile_size, attr->tracefile_size);
+	if (ret) {
+		goto end;
+	}
+
+	/* Count of tracefiles */
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_tracefile_count,
+		attr->tracefile_count);
+	if (ret) {
+		goto end;
+	}
+
+	/* Live timer interval in usec*/
+	ret = mi_lttng_writer_write_element_unsigned_int(writer,
+		config_element_live_timer_interval,
+		attr->live_timer_interval);
+	if (ret) {
+		goto end;
+	}
+
+	/* Closing attributes */
+	ret = mi_lttng_writer_close_element(writer);
+	if (ret) {
+		goto end;
+	}
+end:
+	return ret;
+
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_common_attributes(struct mi_writer *writer,
+		struct lttng_event *event)
+{
+	int ret;
+
+	/* Open event element */
+	ret = mi_lttng_writer_open_element(writer, config_element_event);
+	if (ret) {
+		goto end;
+	}
+
+	/* event name */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_name, event->name);
+	if (ret) {
+		goto end;
+	}
+
+	/* event type */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_type, eventtype_string(event->type));
+	if (ret) {
+		goto end;
+	}
+
+	/* is event enabled */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_enabled, enabled_string(event->enabled));
+	if (ret) {
+		goto end;
+	}
+
+	/* event filter */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_filter, filter_string(event->filter));
+
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_tracepoint_loglevel(struct mi_writer *writer,
+		struct lttng_event *event)
+{
+	int ret;
+
+	/* event loglevel */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_loglevel, loglevel_string(event->loglevel));
+	if (ret) {
+		goto end;
+	}
+
+	/* event exclusion filter */
+	ret = mi_lttng_writer_write_element_string(writer,
+			config_element_exclusion, exclusion_string(event->exclusion));
+	if (ret) {
+		goto end;
+	}
+
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_tracepoint_no_loglevel(struct mi_writer *writer,
+		struct lttng_event *event)
+{
+	/* event exclusion filter */
+	return mi_lttng_writer_write_element_string(writer,
+			config_element_exclusion, exclusion_string(event->exclusion));
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_function_probe(struct mi_writer *writer,
+		struct lttng_event *event)
+{
+	int ret;
+
+	if (event->attr.probe.addr != 0) {
+		/* event probe address */
+		ret = mi_lttng_writer_write_element_unsigned_int(writer,
+				config_element_address, event->attr.probe.addr);
+		if (ret) {
+			goto end;
+		}
+	} else {
+		/* event probe offset */
+		ret = mi_lttng_writer_write_element_unsigned_int(writer,
+				config_element_offset, event->attr.probe.offset);
+		if (ret) {
+			goto end;
+		}
+
+		/* event probe symbol_name */
+		ret = mi_lttng_writer_write_element_string(writer,
+				config_element_symbol_name, event->attr.probe.symbol_name);
+		if (ret) {
+			goto end;
+		}
+	}
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_function_entry(struct mi_writer *writer,
+		struct lttng_event *event)
+{
+	/* event probe symbol_name */
+	return mi_lttng_writer_write_element_string(writer,
+			config_element_symbol_name, event->attr.ftrace.symbol_name);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_events_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, config_element_events);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event(struct mi_writer *writer,
+		struct lttng_event *event, int is_open)
+{
+	int ret;
+
+	ret = mi_lttng_event_common_attributes(writer, event);
+	if (ret) {
+		goto end;
+	}
+
+	switch (event->type) {
+	case LTTNG_EVENT_ALL:
+		/* We should never have "all" events in list. */
+		assert(0);
+		break;
+	case LTTNG_EVENT_TRACEPOINT:
+	{
+		if (event->loglevel != -1) {
+			ret = mi_lttng_event_tracepoint_loglevel(writer, event);
+		} else {
+			ret = mi_lttng_event_tracepoint_no_loglevel(writer, event);
+		}
+		break;
+	}
+	case LTTNG_EVENT_PROBE:
+		ret = mi_lttng_event_function_probe(writer, event);
+		break;
+	case LTTNG_EVENT_FUNCTION_ENTRY:
+		ret = mi_lttng_event_function_entry(writer, event);
+		break;
+	default:
+		break;
+	}
+
+	if (!is_open) {
+		ret = mi_lttng_writer_close_element(writer);
+	}
+
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_pids_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, mi_lttng_element_pids);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *cmdline,
+		int is_open)
+{
+	int ret;
+
+	/* Open element pid */
+	ret = mi_lttng_writer_open_element(writer, mi_lttng_element_pid);
+	if (ret) {
+		goto end;
+	}
+
+	/* Writing pid number */
+	ret = mi_lttng_writer_write_element_signed_int(writer,
+			mi_lttng_element_pid_id, (int)pid);
+	if (ret) {
+		goto end;
+	}
+
+	/* Writing name of the process */
+	ret = mi_lttng_writer_write_element_string(writer, config_element_name,
+			cmdline);
+	if (ret) {
+		goto end;
+	}
+
+	if (!is_open) {
+		/* Closing Pid */
+		ret = mi_lttng_writer_close_element(writer);
+	}
+
+end:
+	return ret;
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_fields_open(struct mi_writer *writer)
+{
+	return mi_lttng_writer_open_element(writer, mi_lttng_element_event_fields);
+}
+
+LTTNG_HIDDEN
+int mi_lttng_event_field(struct mi_writer *writer,
+		struct lttng_event_field *field)
+{
+	int ret;
+
+	if (!field->field_name[0]) {
+		/* To Review: not sure if legal david ?
+		 * how should this be handle ?
+		 */
+		ret = 0;
+		goto end;
+	}
+
+	/* Open field */
+	ret = mi_lttng_writer_open_element(writer, mi_lttng_element_event_field);
+	if (ret) {
+		goto end;
+	}
+
+	if (!field->field_name[0]) {
+		goto close;
+	}
+
+	/* Name */
+	ret = mi_lttng_writer_write_element_string(writer, config_element_name,
+			field->field_name);
+	if (ret) {
+		goto end;
+	}
+
+	/* Type */
+	ret = mi_lttng_writer_write_element_string(writer, config_element_type,
+			eventfieldtype_string(field->type));
+	if (ret) {
+		goto end;
+	}
+
+	/* nowrite  */
+	ret = mi_lttng_writer_write_element_signed_int(writer,
+			mi_lttng_element_nowrite, field->nowrite);
+	if (ret) {
+		goto end;
+	}
+
+close:
+	/* Close field element */
+	ret = mi_lttng_writer_close_element(writer);
+
+end:
+	return ret;
+}
diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
index 69ec0f5..33b5547 100644
--- a/src/common/mi-lttng.h
+++ b/src/common/mi-lttng.h
@@ -63,6 +63,31 @@ const char * const mi_lttng_element_version_license;
 const char * const mi_lttng_element_version_patch_level;
 const char * const mi_lttng_element_version_description;
 
+/* String related to a lttng_event_field */
+const char * const mi_lttng_element_event_field;
+const char * const mi_lttng_element_event_fields;
+
+/* Strings related to pid */
+const char * const mi_lttng_element_pids;
+const char * const mi_lttng_element_pid;
+const char * const mi_lttng_element_pid_id;
+
+/* General element of mi_lttng */
+const char * const mi_lttng_element_type_other;
+const char * const mi_lttng_element_type_integer;
+const char * const mi_lttng_element_type_enum;
+const char * const mi_lttng_element_type_float;
+const char * const mi_lttng_element_type_string;
+const char * const mi_lttng_element_nowrite;
+
+/* Utility string function  */
+const char *enabled_string(int value);
+const char *filter_string(int value);
+const char *exclusion_string(int value);
+const char *loglevel_string(int value);
+const char *logleveltype_string(enum lttng_loglevel_type value);
+const char *eventfieldtype_string(enum lttng_event_field_type value);
+
 /*
  * Create an instance of a machine interface writer.
  *
@@ -130,6 +155,19 @@ int mi_lttng_writer_open_element(struct mi_writer *writer,
 int mi_lttng_writer_close_element(struct mi_writer *writer);
 
 /*
+ * Close multiple element .
+ *
+ * writer An instance of a machine interface writer.
+ *
+ * nb_element
+ *
+ * Returns zero if the XML document could be closed cleanly.
+ * Negative values indicate an error.
+ */
+int mi_lttng_close_multi_element(struct mi_writer *writer,
+		unsigned int nb_element);
+
+/*
  * Write an element of type unsigned int.
  *
  * writer An instance of a machine interface writer.
@@ -207,24 +245,271 @@ int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_version *version,
 		const char *lttng_description, const char *lttng_license);
 
 /*
+ * Machine interface: open a sessions element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_sessions_open(struct mi_writer *writer);
+
+/*
  * Machine interface of struct session.
  *
  * writer An instance of a machine interface writer
  *
  * session An instance of a session
  *
- * isOpen Define if we close the session element
- *        This should be use carefully and the client
- *        need to close the session element.
- *        Use case: nested addition information on a session
+ * is_open Define if we close the session element
+ *         This should be used carefully and the client
+ *         need to close the session element.
+ *         Use case: nested addtionnal information on a session
  *                  ex: domain,channel event.
- *        0-> False
- *        1-> True
+ *         0-> False
+ *         1-> True
  *
  * Returns zero if the element's value could be written.
  * Negative values indicate an error.
  */
 int mi_lttng_session(struct mi_writer *writer,
-		struct lttng_session *session, int isOpen);
+		struct lttng_session *session, int is_open);
+
+/*
+ * Machine interface: open a domains element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_domains_open(struct mi_writer *writer);
+
+/*
+ * Machine interface of struct domain.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * domain An instance of a domain
+ *
+ * is_open Define if we close the domain element
+ *         This should be used carefully and the client
+ *         need to close the domain element.
+ *         Use case: nested addition information on a domain
+ *                  ex: channel event.
+ *         0-> False
+ *         1-> True
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_domain(struct mi_writer *writer,
+		struct lttng_domain *domain, int is_open);
+
+/*
+ * Machine interface: open a channels element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_channels_open(struct mi_writer *writer);
+
+/*
+ * Machine interface of struct channel.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * channel An instance of a channel
+ *
+ * is_open Define if we close the channel element
+ *         This should be used carefully and the client
+ *         need to close the channel element.
+ *         Use case: nested addition information on a domain
+ *                  ex: channel event.
+ *         0-> False
+ *         1-> True
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_channel(struct mi_writer *writer,
+		struct lttng_channel *channel, int is_open);
+
+/*
+ * Machine interface of struct channel_attr.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * attr An instance of a channel_attr struct
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_channel_attr(struct mi_writer *writer,
+		struct lttng_channel_attr *attr);
+
+/*
+* Machine interface for event common attribute.
+*
+* writer An instance of a mi writer.
+*
+* event single trace event.
+*
+* The common attribute are:
+* - mi event element
+* - event name
+* - event type
+* - enabled tag
+* - event filter
+*
+* Returns zero if the element's value could be written.
+* Negative values indicate an error.
+*/
+int mi_lttng_event_common_attributes(struct mi_writer *writer,
+		struct lttng_event *event);
+
+/*
+ * Machine interface for kernel tracepoint event with a loglevel.
+ *
+ * writer An instance of a mi writer.
+ *
+ * event single trace event.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_tracepoint_loglevel(struct mi_writer *writer,
+		struct lttng_event *event);
+
+/*
+ * Machine interface for kernel tracepoint event with no loglevel.
+ *
+ * writer An instance of a mi writer.
+ *
+ * event single trace event.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_tracepoint_no_loglevel(struct mi_writer *writer,
+		struct lttng_event *event);
+
+/*
+ * Machine interface for kernel function and probe event.
+ *
+ * writer An instance of a mi writer.
+ *
+ * event single trace event.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_function_probe(struct mi_writer *writer,
+		struct lttng_event *event);
+
+/*
+ * Machine interface for kernel function entry event.
+ *
+ * writer An instance of a mi writer.
+ *
+ * event single trace event.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_function_entry(struct mi_writer *writer,
+		struct lttng_event *event);
+
+/*
+ * Machine interface: open an events element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_events_open(struct mi_writer *writer);
+
+/*
+ * Machine interface for printing an event.
+ * The trace event type currently supported are:
+ *  TRACEPOINT,
+ *  PROBE,
+ *  FUNCTION,
+ *  FUNCTION_ENTRY,
+ *  SYSCALL
+ *
+ * writer An instance of a mi writer.
+ *
+ * event single trace event.
+ *
+ * is_open Define if we close the event element
+ *         This should be used carefully and the client
+ *         need to close the event element.
+ *         Use case: nested additional information
+ *         0-> False
+ *         1-> True
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event(struct mi_writer *writer, struct lttng_event *event,
+		int is_open);
+
+/*
+ * Machine interface for struct lttng_event_field .
+ *
+ * writer An instance of a mi writer.
+ *
+ * field An event_field instance.
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_field(struct mi_writer *writer,
+		struct lttng_event_field *field);
+
+/*
+ * Machine interface: open a event_fields element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_event_fields_open(struct mi_writer *writer);
+
+/*
+ * Machine interface: open a pids element.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_pids_open(struct mi_writer *writer);
+
+/*
+ * Machine interface of a pid.
+ *
+ * writer An instance of a machine interface writer
+ *
+ * pid A pid
+ *
+ * is_open Define if we close the pid element
+ *         This should be used carefully and the client
+ *         need to close the pid element.
+ *         Use case: nested addition information on a domain
+ *                  ex: channel event.
+ *         0-> False
+ *         1-> True
+ *
+ * Returns zero if the element's value could be written.
+ * Negative values indicate an error.
+ */
+int mi_lttng_pid(struct mi_writer *writer, pid_t pid , const char *cmdline,
+		int is_open);
 
 #endif /* _MI_LTTNG_H */
-- 
1.8.3.2
