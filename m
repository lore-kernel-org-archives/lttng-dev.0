From: nitin.a.kamble@intel.com
Subject: [Patch v2 1/1] asoc.h: fix build with v3.17 kernel
Date: Thu, 25 Sep 2014 18:19:43 -0700
Message-ID: <0344820c621a00d554e1691bbb7ed314c23371fd.1411693988.git.nitin.a.kamble__35004.9206791029$1411694399$gmane$org@intel.com>
References: <cover.1411693988.git.nitin.a.kamble@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga03.intel.com ([134.134.136.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nitin.a.kamble@intel.com>) id 1XXKBk-0001OA-8W
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 21:19:13 -0400
In-Reply-To: <cover.1411693988.git.nitin.a.kamble@intel.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
Cc: Nitin A Kamble <nitin.a.kamble@intel.com>
List-Id: lttng-dev@lists.lttng.org

From: Nitin A Kamble <nitin.a.kamble@intel.com>

The snd_soc_codec structure has changed in the v3.17 kernel. Some
of the redundant fields have been removed. To be specific this commit
from the v3.17 kernel causes the build failure for lttng-modules.

|commit f4333203ec933f9272c90c7add01774ec2cf94d3
|Author: Lars-Peter Clausen <lars@metafoo.de>
|Date:   Mon Jun 16 18:13:02 2014 +0200
|
|    ASoC: Move name and id from CODEC/platform to component
|
|    The component struct already has a name and id field which are initialized to
|    the same values as the same fields in the CODEC and platform structs. So remove
|    them from the CODEC and platform structs and used the ones from the component
|    struct instead.
|
|    Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
|    Signed-off-by: Mark Brown <broonie@linaro.org>

The asoc.h is changed according to the change in the above kernel commit
to fix the lttng-modules build. The change in the lttng-modules code is
conditional on the kernel version, so that it does not break builds with
previous kernel versions.

Signed-off-by: Nitin A Kamble <nitin.a.kamble@intel.com>
---
 instrumentation/events/lttng-module/asoc.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/instrumentation/events/lttng-module/asoc.h b/instrumentation/events/lttng-module/asoc.h
index 672bea4..bf9cf86 100644
--- a/instrumentation/events/lttng-module/asoc.h
+++ b/instrumentation/events/lttng-module/asoc.h
@@ -21,6 +21,14 @@ struct snd_soc_card;
 struct snd_soc_dapm_widget;
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0))
+#define CODEC_NAME_FIELD component.name
+#define CODEC_ID_FIELD component.id
+#else
+#define CODEC_NAME_FIELD name
+#define CODEC_ID_FIELD id
+#endif
+
 /*
  * Log register events
  */
@@ -32,15 +40,15 @@ DECLARE_EVENT_CLASS(snd_soc_reg,
 	TP_ARGS(codec, reg, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
+		__string(	name,		codec->CODEC_NAME_FIELD	)
 		__field(	int,		id		)
 		__field(	unsigned int,	reg		)
 		__field(	unsigned int,	val		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, codec->name)
-		tp_assign(id, codec->id)
+		tp_strcpy(name, codec->CODEC_NAME_FIELD)
+		tp_assign(id, codec->CODEC_ID_FIELD)
 		tp_assign(reg, reg)
 		tp_assign(val, val)
 	),
@@ -77,15 +85,15 @@ DECLARE_EVENT_CLASS(snd_soc_preg,
 	TP_ARGS(platform, reg, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		platform->name	)
+		__string(	name,		platform->CODEC_NAME_FIELD	)
 		__field(	int,		id		)
 		__field(	unsigned int,	reg		)
 		__field(	unsigned int,	val		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, platform->name)
-		tp_assign(id, platform->id)
+		tp_strcpy(name, platform->CODEC_NAME_FIELD)
+		tp_assign(id, platform->CODEC_ID_FIELD)
 		tp_assign(reg, reg)
 		tp_assign(val, val)
 	),
@@ -399,17 +407,17 @@ TRACE_EVENT(snd_soc_cache_sync,
 	TP_ARGS(codec, type, status),
 
 	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
+		__string(	name,		codec->CODEC_NAME_FIELD	)
 		__string(	status,		status		)
 		__string(	type,		type		)
 		__field(	int,		id		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, codec->name)
+		tp_strcpy(name, codec->CODEC_NAME_FIELD)
 		tp_strcpy(status, status)
 		tp_strcpy(type, type)
-		tp_assign(id, codec->id)
+		tp_assign(id, codec->CODEC_ID_FIELD)
 	),
 
 	TP_printk("codec=%s.%d type=%s status=%s", __get_str(name),
-- 
1.8.1.4
