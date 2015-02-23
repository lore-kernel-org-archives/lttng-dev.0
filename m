From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: Update of configure script
Date: Mon, 23 Feb 2015 15:50:35 -0500
Message-ID: <1424724638-4608-1-git-send-email-jonathan.rajotte-julien__22261.1087411225$1424724720$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YPzy1-0000If-1I
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 15:51:02 -0500
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

Hi all,

The following three patches update the autoconf script making sure we have all
the requirements at build time. Nothing special here, simply good practice. 

Cheers!

[PATCH babeltrace 1/3] Configure: add missing check for used funcs
[PATCH babeltrace 2/3] Configure: add check on headers
[PATCH babeltrace 3/3] Configure: add check for type
