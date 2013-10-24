From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH] Add output module which write to an LTTng-UST
	tracepoint
Date: Thu, 24 Oct 2013 15:45:33 -0400
Message-ID: <1382643933-26681-1-git-send-email-yannick.brosseau@gmail.com>
Reply-To: rsyslog-users <rsyslog@lists.adiscon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <rsyslog-bounces@lists.adiscon.com>
List-Unsubscribe: <http://lists.adiscon.net/mailman/options/rsyslog>,
	<mailto:rsyslog-request@lists.adiscon.com?subject=unsubscribe>
List-Archive: <http://lists.adiscon.net/pipermail/rsyslog>
List-Post: <mailto:rsyslog@lists.adiscon.com>
List-Help: <mailto:rsyslog-request@lists.adiscon.com?subject=help>
List-Subscribe: <http://lists.adiscon.net/mailman/listinfo/rsyslog>,
	<mailto:rsyslog-request@lists.adiscon.com?subject=subscribe>
Sender: rsyslog-bounces@lists.adiscon.com
Errors-To: rsyslog-bounces@lists.adiscon.com
To: rsyslog@lists.adiscon.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This module will call a LTTng-UST tracepoint with each syslog entry.
When LTTng is activated, this will write the entries in a CTF
(Common Trace Format) file. This allow the correlating of other trace
sources (kernel traces, other userspace traces) with system events
logged with the syslog deamon.

3 differents tracepoints are available (msg_string, msg_detailled and
msg_detailled_time) and they are selected with the boolean
configuration variables actionomlttngustmsgdetailled and
actionomlttngustlogsyslogtime. The msg_detailled is the default one.

An option to enable its compilation was added to the configure script
(--enable-omlttngust)

Once you load the module, you can activate the tracing with
the lttng command line tool.

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 Makefile.am                             |   4 +
 configure.ac                            |  20 +++
 plugins/omlttngust/Makefile.am          |   8 ++
 plugins/omlttngust/omlttngust.c         | 244 ++++++++++++++++++++++++++++++++
 plugins/omlttngust/rsyslog-tracepoint.h |  79 +++++++++++
 5 files changed, 355 insertions(+)
 create mode 100644 plugins/omlttngust/Makefile.am
 create mode 100644 plugins/omlttngust/omlttngust.c
 create mode 100644 plugins/omlttngust/rsyslog-tracepoint.h

diff --git a/Makefile.am b/Makefile.am
index c5e41c7..341e2b8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -265,6 +265,10 @@ if ENABLE_ORACLE
 SUBDIRS += plugins/omoracle
 endif
 
+if ENABLE_OMLTTNGUST
+SUBDIRS += plugins/omlttngust
+endif
+
 if ENABLE_GUI
 SUBDIRS += java
 endif
diff --git a/configure.ac b/configure.ac
index 2f23147..cd94b3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1425,6 +1425,24 @@ fi
 AM_CONDITIONAL(ENABLE_OMMONGODB, test x$enable_ommongodb = xyes)
 # end of mongodb code
 
+
+#LTTng-ust output SUPPORT
+
+AC_ARG_ENABLE(omlttngust,
+        [AS_HELP_STRING([--enable-omlttngust],[Compiles omlttngust template module @<:@default=no@:>@])],
+        [case "${enableval}" in
+         yes) enable_omlttngust="yes" ;;
+          no) enable_omlttngust="no" ;;
+           *) AC_MSG_ERROR(bad value ${enableval} for --enable-omlttngust) ;;
+         esac],
+        [enable_omlttngust=no]
+)
+if test "x$enable_omlttngust" = "xyes"; then
+	PKG_CHECK_MODULES(LIBLTTNG_UST, lttng-ust >= 2.0)
+fi
+AM_CONDITIONAL(ENABLE_OMLTTNGUST, test x$enable_omlttngust = xyes)
+# end of lttng-ust code
+
 # BEGIN ZMQ3 INPUT SUPPORT
 AC_ARG_ENABLE(imzmq3,
         [AS_HELP_STRING([--enable-imzmq3],[Compiles imzmq3 output module @<:@default=no@:>@])],
@@ -1558,6 +1576,7 @@ AC_CONFIG_FILES([Makefile \
 		plugins/omelasticsearch/Makefile \
 		plugins/sm_cust_bindcdr/Makefile \
 		plugins/mmsnmptrapd/Makefile \
+		plugins/omlttngust/Makefile \
 		java/Makefile \
 		tests/Makefile])
 AC_OUTPUT
@@ -1605,6 +1624,7 @@ echo "    omudpspoof module will be compiled:       $enable_omudpspoof"
 echo "    omuxsock module will be compiled:         $enable_omuxsock"
 echo "    omzmq3 module will be compiled:           $enable_omzmq3"
 echo "    omrabbitmq module will be compiled:       $enable_omrabbitmq"
+echo "    omlttngust module will be compiled:       $enable_omlttngust"
 echo
 echo "---{ parser modules }---"
 echo "    pmrfc3164sd module will be compiled:      $enable_pmrfc3164sd"
diff --git a/plugins/omlttngust/Makefile.am b/plugins/omlttngust/Makefile.am
new file mode 100644
index 0000000..8a2f2c3
--- /dev/null
+++ b/plugins/omlttngust/Makefile.am
@@ -0,0 +1,8 @@
+pkglib_LTLIBRARIES = omlttngust.la
+
+omlttngust_la_SOURCES = omlttngust.c
+omlttngust_la_CPPFLAGS =  $(RSRT_CFLAGS) $(PTHREADS_CFLAGS) $(LIBLTTNG_UST_CFLAGS)
+omlttngust_la_LDFLAGS = -module -avoid-version
+omlttngust_la_LIBADD =  $(LIBLTTNG_UST_LIBS)
+
+EXTRA_DIST = 
diff --git a/plugins/omlttngust/omlttngust.c b/plugins/omlttngust/omlttngust.c
new file mode 100644
index 0000000..cb4639f
--- /dev/null
+++ b/plugins/omlttngust/omlttngust.c
@@ -0,0 +1,244 @@
+/* omlttngust.c
+ * send all output to an LTTng-UST tracepoint
+ *
+ * Copyright 2013 Yannick Brosseau
+ *
+ * This file is part of rsyslog.
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ * 
+ *       http://www.apache.org/licenses/LICENSE-2.0
+ *       -or-
+ *       see COPYING.ASL20 in the source distribution
+ * 
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+#include "config.h"
+#include "rsyslog.h"
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include <signal.h>
+#include <errno.h>
+#include <unistd.h>
+#include "conf.h"
+#include "syslogd-types.h"
+#include "srUtils.h"
+#include "template.h"
+#include "module-template.h"
+#include "errmsg.h"
+#include "cfsysline.h"
+
+#include <lttng/ust.h>
+
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+/*
+ * The header containing our TRACEPOINT_EVENTs.
+ */
+
+#include "rsyslog-tracepoint.h"
+
+MODULE_TYPE_OUTPUT
+MODULE_TYPE_NOKEEP
+MODULE_CNFNAME("omlttngust")
+
+static rsRetVal resetConfigVariables(uchar __attribute__((unused)) *pp, void __attribute__((unused)) *pVal);
+
+/* internal structures
+ */
+DEF_OMOD_STATIC_DATA
+
+/* config variables */
+
+
+typedef struct _instanceData {
+	int bUseMsgInterface; /* 1 - Use the msg interface and write to detailled tracepoint 0 - Write the whole entry as a string */
+	int bLogSyslogTime; /* 1 - With the detailled tracepoint, write a time string with the syslog timestamp */
+} instanceData;
+
+typedef struct configSettings_s {
+	int bUseMsgInterface;
+	int bLogSyslogTime;
+} configSettings_t;
+static configSettings_t cs;
+
+BEGINinitConfVars		/* (re)set config variables to default values */
+CODESTARTinitConfVars 
+	resetConfigVariables(NULL, NULL);
+ENDinitConfVars
+
+BEGINcreateInstance
+CODESTARTcreateInstance
+ENDcreateInstance
+
+
+BEGINisCompatibleWithFeature
+CODESTARTisCompatibleWithFeature
+	if(eFeat == sFEATURERepeatedMsgReduction)
+		iRet = RS_RET_OK;
+ENDisCompatibleWithFeature
+
+
+BEGINfreeInstance
+CODESTARTfreeInstance
+ENDfreeInstance
+
+
+BEGINdbgPrintInstInfo
+CODESTARTdbgPrintInstInfo
+ENDdbgPrintInstInfo
+
+
+BEGINtryResume
+CODESTARTtryResume
+ENDtryResume
+
+static int
+processMsg(msg_t *pMsg, int bWantTimestampField)
+{
+	uchar *msg; short unsigned msg_free; rs_size_t msg_len;
+	uchar *procid; short unsigned procid_free; rs_size_t procid_len;
+	int severity, facil;
+	uchar *hostname; short unsigned sys_free; rs_size_t sys_len;
+	uchar *timestamp; short unsigned timestamp_free; rs_size_t timestamp_len;
+	uchar *time_gen; short unsigned time_gen_free; rs_size_t time_gen_len;
+	uchar *pid; short unsigned pid_free; rs_size_t pid_len;
+
+	msg = MsgGetProp(pMsg, NULL, PROP_MSG, NULL, &msg_len, &msg_free, NULL);
+	procid = MsgGetProp(pMsg, NULL, PROP_PROGRAMNAME, NULL, &procid_len, &procid_free, NULL);
+	hostname = MsgGetProp(pMsg, NULL, PROP_HOSTNAME, NULL, &sys_len, &sys_free, NULL);
+	
+	pid = MsgGetProp(pMsg, NULL, PROP_PROCID, NULL, &pid_len, &pid_free, NULL);
+
+	severity = pMsg->iSeverity;
+	facil = pMsg->iFacility;
+
+	if(bWantTimestampField) {
+		/* TODO Set a template format to get the miliseconds? */
+		timestamp = MsgGetProp(pMsg, NULL, PROP_TIMESTAMP, NULL, &timestamp_len, &timestamp_free, NULL);
+		
+		time_gen = MsgGetProp(pMsg, NULL, PROP_TIMEGENERATED, NULL, &time_gen_len, &time_gen_free, NULL);
+	
+		tracepoint(rsyslog, msg_detailled_time, (char *) msg, severity, facil, hostname, procid, pid, timestamp, time_gen);	
+	} else {
+		tracepoint(rsyslog, msg_detailled, (char *) msg, severity, facil, hostname, procid, pid);
+	}
+
+
+	return 0;
+}
+BEGINdoAction
+	char *toWrite;
+CODESTARTdoAction
+
+
+        if(pData->bUseMsgInterface) {
+		processMsg((msg_t*)ppString[0], pData->bLogSyslogTime);
+	} else {
+		/* Use the simple formated string when msg parsing is not used */
+		toWrite = (char*) ppString[0];
+	
+		tracepoint(rsyslog, msg_string, toWrite);
+
+	}
+ENDdoAction
+
+
+BEGINparseSelectorAct
+	int iTplOpts;
+CODESTARTparseSelectorAct
+CODE_STD_STRING_REQUESTparseSelectorAct(1)
+	/* first check if this config line is actually for us */
+	if(strncmp((char*) p, ":omlttngust:", sizeof(":omlttngust:") - 1)) {
+		ABORT_FINALIZE(RS_RET_CONFLINE_UNPROCESSED);
+	}
+
+	/* ok, if we reach this point, we have something for us */
+	p += sizeof(":omlttngust:") - 1; /* eat indicator sequence  (-1 because of '\0'!) */
+	CHKiRet(createInstance(&pData));
+
+	/* check if a non-standard template is to be applied */
+	if(*(p-1) == ';')
+		--p;
+	iTplOpts = (cs.bUseMsgInterface == 0) ? 0 : OMSR_TPL_AS_MSG ;
+
+	CHKiRet(cflineParseTemplateName(&p, *ppOMSR, 0, iTplOpts, (uchar*) "RSYSLOG_FileFormat"));
+	pData->bUseMsgInterface = cs.bUseMsgInterface;
+        pData->bLogSyslogTime = cs.bLogSyslogTime;
+CODE_STD_FINALIZERparseSelectorAct
+ENDparseSelectorAct
+
+
+BEGINmodExit
+CODESTARTmodExit
+ENDmodExit
+
+
+BEGINqueryEtryPt
+CODESTARTqueryEtryPt
+CODEqueryEtryPt_STD_OMOD_QUERIES
+CODEqueryEtryPt_STD_CONF2_CNFNAME_QUERIES 
+ENDqueryEtryPt
+
+
+
+/* Reset config variables for this module to default values.
+ */
+static rsRetVal resetConfigVariables(uchar __attribute__((unused)) *pp, void __attribute__((unused)) *pVal)
+{
+	DEFiRet;
+	cs.bUseMsgInterface = 1;
+	cs.bLogSyslogTime = 0;
+	RETiRet;
+}
+
+
+BEGINmodInit()
+	rsRetVal localRet;
+	rsRetVal (*pomsrGetSupportedTplOpts)(unsigned long *pOpts);
+	unsigned long opts;
+	int bMsgPassingSupported;	       
+CODESTARTmodInit
+INITLegCnfVars
+	*ipIFVersProvided = CURR_MOD_IF_VERSION; /* we only support the current interface specification */
+CODEmodInit_QueryRegCFSLineHdlr
+
+	/* check if the rsyslog core supports parameter passing code */
+        bMsgPassingSupported = 0;
+	localRet = pHostQueryEtryPt((uchar*)"OMSRgetSupportedTplOpts", &pomsrGetSupportedTplOpts);
+	if(localRet == RS_RET_OK) {
+		/* found entry point, so let's see if core supports array passing */
+		CHKiRet((*pomsrGetSupportedTplOpts)(&opts));
+		if(opts & OMSR_TPL_AS_MSG)
+			bMsgPassingSupported = 1;
+	} else if(localRet != RS_RET_ENTRY_POINT_NOT_FOUND) {
+		ABORT_FINALIZE(localRet); /* Something else went wrong, what is not acceptable */
+	}
+	DBGPRINTF("omlttngust: msg-passing is %ssupported by rsyslog core.\n", bMsgPassingSupported ? "" : "not ");
+
+	if(bMsgPassingSupported) {
+		/* enable config command only if core supports msg passing */
+		CHKiRet(omsdRegCFSLineHdlr((uchar *)"actionomlttngustmsgdetailled", 0, eCmdHdlrBinary, NULL,
+			                   &cs.bUseMsgInterface, STD_LOADABLE_MODULE_ID));
+
+
+		CHKiRet(omsdRegCFSLineHdlr((uchar *)"actionomlttngustlogsyslogtime", 0, eCmdHdlrBinary, NULL,
+			                   &cs.bLogSyslogTime, STD_LOADABLE_MODULE_ID));
+	}
+
+	CHKiRet(omsdRegCFSLineHdlr((uchar *)"resetconfigvariables", 1, eCmdHdlrCustomHandler,
+				    resetConfigVariables, NULL, STD_LOADABLE_MODULE_ID));
+
+ENDmodInit
+
+/* vi:set ai:
+ */
diff --git a/plugins/omlttngust/rsyslog-tracepoint.h b/plugins/omlttngust/rsyslog-tracepoint.h
new file mode 100644
index 0000000..037364b
--- /dev/null
+++ b/plugins/omlttngust/rsyslog-tracepoint.h
@@ -0,0 +1,79 @@
+
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER rsyslog
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./rsyslog-tracepoint.h"
+
+
+#ifdef __cplusplus
+extern "C"{
+#endif /* __cplusplus */
+
+
+#if !defined(RSYSLOG_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define RSYSLOG_H
+
+#include <lttng/tracepoint.h>
+
+TRACEPOINT_EVENT(
+	rsyslog,
+	msg_string, 
+	TP_ARGS(char *, text),
+	TP_FIELDS(
+		ctf_string(message, text)
+		  )
+)
+
+TRACEPOINT_EVENT(
+	rsyslog,
+	msg_detailled, 
+	TP_ARGS(char *, text, int, severity, int, facility, uchar*, hostname, uchar*, progname, uchar *, pid ),
+	TP_FIELDS(
+		ctf_string(message, text)
+		ctf_integer(int, severity, severity)
+		ctf_integer(int, facility, facility)
+		ctf_string(hostname, hostname)
+		ctf_string(progname, progname)
+		ctf_string(pid, pid)
+		  )
+)
+
+TRACEPOINT_EVENT(
+	rsyslog,
+	msg_detailled_time, 
+	TP_ARGS(char *, text, int, severity, int, facility, uchar*, hostname, uchar*, progname,  uchar *, pid, uchar *, time, uchar*, time_gen),
+	TP_FIELDS(
+		ctf_string(message, text)
+		ctf_integer(int, severity, severity)
+		ctf_integer(int, facility, facility)
+		ctf_string(hostname, hostname)
+		ctf_string(progname, progname)
+		ctf_string(pid, pid)
+		ctf_string(time_str, time)
+		ctf_string(time_gen_str, time_gen)
+		  )
+)
+
+TRACEPOINT_EVENT(
+		 rsyslog,
+		 init,
+		 TP_ARGS(),
+		 TP_FIELDS()
+		 )
+
+TRACEPOINT_EVENT(
+		 rsyslog,
+		 config,
+		 TP_ARGS(),
+		 TP_FIELDS()
+		 )
+
+#endif /* RSYSLOG_H */
+
+#include <lttng/tracepoint-event.h>
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
-- 
1.8.4.rc3
