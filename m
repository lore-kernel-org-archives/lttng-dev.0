From: Hui Zhu <teawater@gmail.com>
Subject: [PATCH/babeltrace] Fix babeltrace-log get big line when
 the input file last line don't have enter
Date: Tue, 11 Sep 2012 15:19:09 +0800
Message-ID: <CANFwon2S_FHYGeTJ7jS1iHhdiofPEEQihBanAsHGW0d1Tv+sfg__31764.7902098999$1347348071$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1TBKlH-0005SO-1V
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 03:19:55 -0400
Received: by vcbfl11 with SMTP id fl11so273066vcb.35
	for <lttng-dev@lists.lttng.org>; Tue, 11 Sep 2012 00:19:49 -0700 (PDT)
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

Hi,

I got:
[Error] Line too large for packet size (32kB) (discarded)
When I input a file to babeltrace-log.
That is because the last line of the input file doesn't have enter and
"babeltrace-log" have bug with the line that doesn't have enter.
So I post a patch for it.

Thanks,
Hui

--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -240,9 +240,11 @@ void trace_text(FILE *input, int output)
 		if (len < 0)
 			break;
 		nl = strrchr(line, '\n');
-		if (nl)
+		if (nl) {
 			*nl = '\0';
-		trace_string(line, &pos, nl - line + 1);
+			trace_string(line, &pos, nl - line + 1);
+		} else
+			trace_string(line, &pos, strlen(line) + 1);
 	}
 	ctf_fini_pos(&pos);
 }
