From: Jan Glauber <jan.glauber@gmail.com>
Subject: lttng-tools liburcu path
Date: Thu, 27 Mar 2014 11:34:54 +0100
Message-ID: <20140327103453.GA29197__47321.704743854$1395916588$gmane$org@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1WT7f6-0001j4-Un
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 06:35:53 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so2703833eek.10
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 03:35:46 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

I'm getting linker errors for lttng-tools, due to an older version of
liburcu (<0.7) installed. Now I was looking for a configure switch to
specify where the liburcu that should be used is but I didn't find one.

Would it be possible to add something like --with-xml-prefix= but for
luburcu?

thanks, Jan
