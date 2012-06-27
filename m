From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: [PATCH] tracepoint event exclusion
Date: Wed, 27 Jun 2012 16:08:14 +0200
Message-ID: <4FEB13CE.1010206__47155.7720019065$1340806099$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060108080706020303040007"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1SjsuL-0004Dn-PS
	for lttng-dev@lists.lttng.org; Wed, 27 Jun 2012 10:07:49 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1SjsuE-00058R-Vu from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 27 Jun 2012 07:07:43 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------060108080706020303040007
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id q5RE7pKa019456

Hi,

In order to support situations where a user wants generally all=20
tracepoints enabled but specific tracepoints to be suppressed during a=20
trace session, I created a small patch that allows us to do the following=
:

...
lttng enable-event -u -c met_tools -a
lttng enable-event -u -c met_tools --tracepoint '!met_func:*'
lttng enable-event -u -c met_tools --tracepoint '!met_call:*'
...

This has the effect that all tracepoints get recorded except for=20
tracepoints that match met_func:* or met_call:*.

If you think this feature is useful for others we would be happy to see=20
this patch merged into trunk.

Thanks,
Paul

--=20
Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.


--------------060108080706020303040007
Content-Type: text/x-patch; name="event_exclusion.patch"
Content-Disposition: attachment; filename="event_exclusion.patch"
Content-Transfer-Encoding: 7bit

From 74602f6f4ea4b1d7faa01f76542f62b496b94091 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Wed, 27 Jun 2012 15:21:30 +0200
Subject: [PATCH] Added excluding/filtering of events with !NAME

---
 liblttng-ust/ltt-events.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust/ltt-events.c b/liblttng-ust/ltt-events.c
index 0fdfd2f..b663312 100644
--- a/liblttng-ust/ltt-events.c
+++ b/liblttng-ust/ltt-events.c
@@ -150,11 +150,32 @@ struct wildcard_entry *match_wildcard(const struct lttng_event_desc *desc)
 	struct wildcard_entry *e;
 
 	cds_list_for_each_entry(e, &wildcard_list, list) {
+	    size_t len = strlen(e->name);
+	    if (len < 1 || e->name[0] != '!')
+		continue;
+
+	    DBG("Filter %s against wildcard_entry %s\n", desc->name, e->name);
+
+	    /* Compare exclusion wildcards excluding initial '!' and final '*' */
+	    if (!strncmp(desc->name, e->name + 1, len - 2))
+	    {
+		DBG("Exclude %s due to exclusion wildcard_entry %s\n", desc->name, e->name);
+		return NULL; /* exclusion wildcard matched */
+	    }
+	}
+
+	cds_list_for_each_entry(e, &wildcard_list, list) {
+	    size_t len = strlen(e->name);
+	    if (len > 0 && e->name[0] == '!')
+		continue;
+
+	    DBG("Match %s against wildcard_entry %s\n", desc->name, e->name);
+
 		/* If only contain '*' */
-		if (strlen(e->name) == 1)
+		if (len == 1)
 			goto possible_match;
 		/* Compare excluding final '*' */
-		if (!strncmp(desc->name, e->name, strlen(e->name) - 1))
+		if (!strncmp(desc->name, e->name, len - 1))
 			goto possible_match;
 		continue;	/* goto next, no match */
 	possible_match:
@@ -507,6 +528,13 @@ int ltt_event_create(struct ltt_channel *chan,
 	struct ltt_event *event;
 	int ret = 0;
 
+	if (strlen(event_param->name) > 0 && event_param->name[0] == '!')
+	{
+	    struct session_wildcard *sw = NULL;
+	    ltt_wildcard_create(chan, event_param, &sw );
+	    goto filter;
+	}
+
 	if (chan->used_event_id == -1U) {
 		ret = -ENOMEM;
 		goto full;
@@ -607,6 +635,7 @@ cache_error:
 no_loglevel_match:
 exist:
 full:
+filter:
 	return ret;
 }
 
-- 
1.7.10.4


--------------060108080706020303040007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------060108080706020303040007--
