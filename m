From: Franck Balazot <franck.balazot@oneaccess-net.com>
Subject: Using same provider:tracepoint probe in several
	processes
Date: Fri, 6 Mar 2015 16:31:13 +0100
Message-ID: <54F9C841.4080304__17961.474080994$1425655933$gmane$org@oneaccess-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail2.belgium.oneaccess-net.com ([91.183.184.101]
 helo=mail.oneaccess-net.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Franck.Balazot@oneaccess-net.com>)
 id 1YTuDg-0002lq-BG
 for lttng-dev@lists.lttng.org; Fri, 06 Mar 2015 10:31:24 -0500
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

I would like to know if it is possible to use the same 
provider:tracepoint probe in several processes, without getting 
following error :

LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate 
registration of tracepoint probes having the same name is not allowed.
Aborted (core dumped)

And how to do it ?

Franck
