From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Answer to lttng perf counter question
Date: Tue, 2 Jun 2015 19:18:02 +0000 (UTC)
Message-ID: <486803943.2301.1433272682582.JavaMail.zimbra__21816.8708998293$1433272760$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YzrhW-0000DV-Uj
 for lttng-dev@lists.lttng.org; Tue, 02 Jun 2015 15:18:16 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Here is an answer to a question that was asked on #lttng today. Unfortunately,
the user left before we could answer.

10:13 < bonthink> Hi! Could someone help me? I am having problems after adding one specific perf counter perf:thread:stalled-cycles-frontend. If I do so, I 
                  am unable to view the traces afterwards. However other perf counters work fine. lttng 2.5.0
10:15 < bonthink> If using the hello example from the lttng doc it looks like this:
10:15 < bonthink> lttng view Trace directory: /home/user/lttng-traces/auto-20150602-160131  [error] Cannot open any trace for reading.  [error] opening 
                  trace "/home/aburov/lttng-traces/auto-20150602-160131" for reading.  [error] none of the specified trace paths could be opened.
10:16 < bonthink> and with some other perf counter
10:16 < bonthink> lttng view Trace directory: /home/aburov/lttng-traces/auto-20150602-160224  [16:03:14.431724221] (+?.?????????) krypton.tbricks.com 
                  hello_world:my_first_tracepoint: { cpu_id = 1 }, { perf_thread_cycles = 281474976715686 }, { my_string_field = "hi there!", 
                  my_integer_field = 23 } [16:03:14.432296656] (+0.000572435) krypton.tbricks.com hello_world:my_first_tracepoint: { cpu_id = 1 }, { 
                  perf_thread_cycles = 281474976722947 }, { my_s

Answer:

15:15 < Compudj> for bonthink (who is now gone): need to upgrade lttng version, looks like an already fixed issue about 64-bit contexts

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
