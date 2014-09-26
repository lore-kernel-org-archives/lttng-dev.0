From: nitin.a.kamble@intel.com
Subject: [PATCH 1/1] asoc.h: fix build with v3.17 kernel
Date: Thu, 25 Sep 2014 17:12:43 -0700
Message-ID: <320e3b85c08b3ddcdfe4789c5fa843612cb24e5c.1411690005.git.nitin.a.kamble__45312.097334727$1411690382$gmane$org@intel.com>
References: <cover.1411690005.git.nitin.a.kamble@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga11.intel.com ([192.55.52.93])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nitin.a.kamble@intel.com>) id 1XXJ8s-00010t-Qd
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 20:12:13 -0400
In-Reply-To: <cover.1411690005.git.nitin.a.kamble@intel.com>
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
to fix the lttng-modules build.

Signed-off-by: Nitin A Kamble <nitin.a.kamble@intel.com>
---
 instrumentation/events/lttng-module/asoc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/instrumentation/events/lttng-module/asoc.h b/instrumentation/events/lttng-module/asoc.h
index 672bea4..19d25bf 100644
--- a/instrumentation/events/lttng-module/asoc.h
+++ b/instrumentation/events/lttng-module/asoc.h
@@ -32,15 +32,15 @@ DECLARE_EVENT_CLASS(snd_soc_reg,
 	TP_ARGS(codec, reg, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
+		__string(	name,		codec->component.name	)
 		__field(	int,		id		)
 		__field(	unsigned int,	reg		)
 		__field(	unsigned int,	val		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, codec->name)
-		tp_assign(id, codec->id)
+		tp_strcpy(name, codec->component.name)
+		tp_assign(id, codec->component.id)
 		tp_assign(reg, reg)
 		tp_assign(val, val)
 	),
@@ -77,15 +77,15 @@ DECLARE_EVENT_CLASS(snd_soc_preg,
 	TP_ARGS(platform, reg, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		platform->name	)
+		__string(	name,		platform->component.name	)
 		__field(	int,		id		)
 		__field(	unsigned int,	reg		)
 		__field(	unsigned int,	val		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, platform->name)
-		tp_assign(id, platform->id)
+		tp_strcpy(name, platform->component.name)
+		tp_assign(id, platform->component.id)
 		tp_assign(reg, reg)
 		tp_assign(val, val)
 	),
@@ -399,17 +399,17 @@ TRACE_EVENT(snd_soc_cache_sync,
 	TP_ARGS(codec, type, status),
 
 	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
+		__string(	name,		codec->component.name	)
 		__string(	status,		status		)
 		__string(	type,		type		)
 		__field(	int,		id		)
 	),
 
 	TP_fast_assign(
-		tp_strcpy(name, codec->name)
+		tp_strcpy(name, codec->component.name)
 		tp_strcpy(status, status)
 		tp_strcpy(type, type)
-		tp_assign(id, codec->id)
+		tp_assign(id, codec->component.id)
 	),
 
 	TP_printk("codec=%s.%d type=%s status=%s", __get_str(name),
-- 
1.8.1.4
