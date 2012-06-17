From: Lars <lars@grandepotatis.se>
Subject: LTTng-UST alternative to LD_PRELOAD
Date: Sun, 17 Jun 2012 17:08:23 +0200
Message-ID: <1339945703.2599.21.camel__39691.0668154762$1339947405$gmane$org@DellE5500>
Reply-To: lars@grandepotatis.se
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail14.surf-town.net ([212.97.132.54]
	helo=mailgw13.surf-town.net) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lars@grandepotatis.se>) id 1SgH5N-0005ip-5v
	for lttng-dev@lists.lttng.org; Sun, 17 Jun 2012 11:08:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailgw13.surf-town.net (Postfix) with ESMTP id ADEAA404EA
	for <lttng-dev@lists.lttng.org>; Sun, 17 Jun 2012 17:08:15 +0200 (CEST)
Received: from mailgw13.surf-town.net ([127.0.0.1])
	by localhost (mailgw13.surf-town.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id TfriU47lSTUj for <lttng-dev@lists.lttng.org>;
	Sun, 17 Jun 2012 17:08:10 +0200 (CEST)
Received: from [192.168.1.101] (90-231-55-174-no23.tbcn.telia.com
	[90.231.55.174])
	by mailgw13.surf-town.net (Postfix) with ESMTPSA id 5AD3240837
	for <lttng-dev@lists.lttng.org>; Sun, 17 Jun 2012 17:08:10 +0200 (CEST)
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


Hello,

I have recently started to use LTTng-UST and am using LD_PRELOAD
to make it possilbe to execute instrumented code on systems without
LTTng-UST installed.

To define LD_PRELOAD however affects too much. For instance all
forked processes also get the library loaded. This can be fixed by
removing the library from the LD_PRELOAD variable early in the main
function. This looks odd and required some explaining in comments.

Also, in my case, the instrumented program is started with a "wrapper"
program which I can not alter. This wrapper also gets the library
loaded.

As an alternative to using LD_PRELOAD I would like to use an explicit
function, like;

  int traceload(char const* library_path);

that is called early in main (instead of the LD_PRELOAD environment
manipulation) and loads the library with dlopen if it exists.

I have already tried this (of course) and it almost works already.
The tracepoints becomes visible but I get no trace data written.
So I think a really small modification is needed.

Is anything like this planned?

Or can anybody give me a hint on what is missing?

I checked the mailing list a couple of months back but did not
find anything.

Best Regards,
Lars Ekman
