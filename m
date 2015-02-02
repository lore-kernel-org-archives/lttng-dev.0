From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Autoconf script update
Date: Mon,  2 Feb 2015 16:33:53 -0500
Message-ID: <1422912837-5003-1-git-send-email-jonathan.rajotte-julien__28321.6110700325$1422912943$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1YIOdO-0001Ug-PE
 for lttng-dev@lists.lttng.org; Mon, 02 Feb 2015 16:34:25 -0500
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

Hi,

While working on improving support of java test in for CI(Jenkins) and having
fun with autoconf I decided to run autoscan. It look like the lttng autoconf
script is missing some check here and there. This patch set aims to help a little.

Some of those checks might have been left out purposely. If so we might want to
document why somewhere for future reference.
 
Cheers!

Jonathan
