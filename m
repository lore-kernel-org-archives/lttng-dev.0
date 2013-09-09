From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Getting function names with lttng-ust-cyg-profile.so
Date: Mon, 09 Sep 2013 18:46:38 -0400
Message-ID: <522E4FCE.7070000__11615.6628275805$1378766914$gmane$org@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VJAFA-0001m0-3k
	for lttng-dev@lists.lttng.org; Mon, 09 Sep 2013 18:47:45 -0400
Received: from [10.11.0.30] (unknown [10.11.0.30])
	by mail.voxpopuli.im (Postfix) with ESMTPSA id 9B74A80D116
	for <lttng-dev@lists.lttng.org>; Mon,  9 Sep 2013 18:47:40 -0400 (EDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

I've recently started playing with liblttng-ust-cyg-profile.so (aka,
getting UST events from -finstrument-functions), and I have to say it's
pretty nifty! I haven't done any benchmarks, but it's certainly faster
than the typical printf() that people use with it...

However, in the resulting trace, one only gets the addresses of the
functions. I understand how it's relatively "easy" for the seasoned user
to use nm or addr2line to get the actual function names, but would it
possible - and how hard would it be - to have this information (function
names) directly in the trace?


I'm trying to leverage this feature in Eclipse TMF to display a call
stack for such UST traces. And to be honest, displaying a call stack
with only the function addresses is completely useless, we need the
function names.

We could have the user import a text file (which he can generate with
"nm appname > file.txt" for example). But then he needs the original
binary, which he might not have. And that binary needs to be compiled
with debugging symbols. If the function name information was already in
the trace, it would make the user experience much better, and our job
much easier! ;)


Thoughts?

Thanks,
Alex
