From: Franck Balazot <franck.balazot@oneaccess-net.com>
Subject: Using tracepoint call inside a macro
Date: Tue, 21 Apr 2015 11:21:56 +0200
Message-ID: <553616B4.4060706__7109.71309240467$1429608195$gmane$org@oneaccess-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail2.belgium.oneaccess-net.com ([91.183.184.101]
 helo=mail.oneaccess-net.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Franck.Balazot@oneaccess-net.com>)
 id 1YkUNY-0007wd-1Y
 for lttng-dev@lists.lttng.org; Tue, 21 Apr 2015 05:22:09 -0400
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

I wonder if it is possible to define a macro containing a tracepoint 
(which is also a macro) call.

As a very simple example, using :

#define TRACE(subsystem, tracepoint, params...) tracepoint(subsystem, 
tracepoint, params)

TRACE(provider, tp1, arg);

is not compiling (tracepoint macro seems not to be expanded), whereas 
direct call

tracepoint(provider, tp1, arg);

is compiling.

Any idea ?

BR
Franck
