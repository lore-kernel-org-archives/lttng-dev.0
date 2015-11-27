From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
Subject: lttng on aarch64 platform
Date: Fri, 27 Nov 2015 18:30:34 +0100
Message-ID: <5658933A.4060408__22965.8337346793$1448752230$gmane$org@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.aswsp.com ([193.34.35.150])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ronan.chauvin@parrot.com>) id 1a2Mqx-0002o9-4n
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 12:30:36 -0500
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

Hello all,

I am trying to use lttng 2.7.0 on an aarch64 platform. When I create my 
session a trap is triggered which indicated that a unknow syscall (389) 
is called.

/ # lttng -vvv create mysession
DEBUG1 - 02:36:22.271714 [850/850]: Session daemon binary path: 
/usr/bin/lttng-sessiond (in launch_sessiond() at commands/create.c:668)
Spawning a session daemon
DEBUG1 - 02:36:24.275751 [850/850]: Session daemon terminated normally 
(exit status: 1) (in spawn_sessiond() at commands/create.c:606)
Error: Session daemon terminated with an error (exit status: 1)
Error: Problem occurred while launching session daemon 
(/usr/bin/lttng-sessiond)
Error: Command error
DEBUG1 - 02:36:24.275899 [850/850]: Clean exit (in clean_exit() at 
lttng.c:193)

It seems that lttng-sessiond deamon is directly exited. Has anyone 
already tried on a 3.10 kernel and aarch64 platform?

Thanks in advance,

-- 
Ronan CHAUVIN
Embedded Software Engineer
ASIC & Video team
--------------------------------
Parrot SA
174, quai de Jemmapes
75010 Paris, France
--------------------------------
www.parrot.com
