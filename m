From: Christian Ascheberg <caschebe@techfak.uni-bielefeld.de>
Subject: Problem LD_PRELOADing multiple UST helpers
Date: Wed, 21 Oct 2015 15:25:02 +0200
Message-ID: <5627922E.9000808__24772.1853819259$1445433982$gmane$org@techfak.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smarthost.techfak.uni-bielefeld.de ([129.70.137.17])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <caschebe@techfak.uni-bielefeld.de>)
 id 1ZotO9-00052m-Sm
 for lttng-dev@lists.lttng.org; Wed, 21 Oct 2015 09:25:16 -0400
Received: from [IPv6:2001:638:504:209c:224:8cff:fe6b:5a13] (unknown
 [IPv6:2001:638:504:209c:224:8cff:fe6b:5a13])
 (Authenticated sender: caschebe)
 by smarthost.TechFak.Uni-Bielefeld.DE (Postfix) with ESMTPA id 858F78000C
 for <lttng-dev@lists.lttng.org>; Wed, 21 Oct 2015 15:25:02 +0200 (CEST)
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

Hello,

I am having a strange problem with LTTng UST helpers on a Cyclone V ARM 
development board. If I LD_PRELOAD multiple helpers, then only data of 
the first loaded helper appears in the trace.
Below I have some debug output that looks wrong:

This is the command:
root@cyclone5:~# LTTNG_UST_DEBUG=1 
LD_PRELOAD="liblttng-ust-libc-wrapper.so liblttng-ust-cyg-profile.so 
liblttng-ust-pthread-wrapper.so liblttng-ust-dl.so" ls

- This is some output regarding the first registration:
liblttng_ust_tracepoint[XXX/XXX]: just registered a tracepoints section 
from 0x76e7b42c and having 2 tracepoints (in tracepoint_register_lib() 
at tracepoint.c:767)
liblttng_ust_tracepoint[XXX/XXX]: registered tracepoint: 
ust_baddr_statedump:soinfo (in tracepoint_register_lib() at 
tracepoint.c:772)
liblttng_ust_tracepoint[XXX/XXX]: registered tracepoint: 
lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)
libust[XXX/XXX]: Provider "ust_baddr_statedump" accepted, version 1.0 is 
compatible with LTTng UST provider version 1.0. (in 
check_provider_version() at lttng-probes.c:174)
libust[XXX/XXX]: adding probe ust_baddr_statedump containing 1 events to 
lazy registration list (in lttng_probe_register() at lttng-probes.c:216)
libust[XXX/XXY]: just registered probe ust_baddr_statedump containing 1 
events (in lttng_lazy_probe_register() at lttng-probes.c:115)
libust[XXX/XXY]: Sent register event notification for name 
"ust_baddr_statedump:soinfo": ret_code 0, event_id 0
  (in ustcomm_register_event() at lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[XXX/XXY]: Registering probe to tracepoint 
ust_baddr_statedump:soinfo (in __tracepoint_probe_register() at 
tracepoint.c:563)
liblttng_ust_tracepoint[XXX/XXX]: Registering probe to tracepoint 
lttng_ust_tracef:event (in __tracepoint_probe_register() at 
tracepoint.c:563)

- And here is some strange output regarding another registration:
liblttng_ust_tracepoint[XXX/XXX]: just registered a tracepoints section 
from 0x76e7b42c and having 2 tracepoints (in tracepoint_register_lib() 
at tracepoint.c:767)
liblttng_ust_tracepoint[XXX/XXX]: registered tracepoint: 
ust_baddr_statedump:soinfo (in tracepoint_register_lib() at 
tracepoint.c:772)
liblttng_ust_tracepoint[XXX/XXX]: registered tracepoint: 
lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)
libust[XXX/XXX]: Provider "ust_pthread" accepted, version 1.0 is 
compatible with LTTng UST provider version 1.0. (in 
check_provider_version() at lttng-probes.c:174)
libust[XXX/XXX]: adding probe ust_pthread containing 4 events to lazy 
registration list (in lttng_probe_register() at lttng-probes.c:216)
libust[XXX/XXX]: just registered probe ust_pthread containing 4 events 
(in lttng_lazy_probe_register() at lttng-probes.c:115)
libust[XXX/XXX]: Sent register event notification for name 
"ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 4
  (in ustcomm_register_event() at lttng-ust-comm.c:1001)
libust[XXX/XXX]: Sent register event notification for name 
"ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 5
  (in ustcomm_register_event() at lttng-ust-comm.c:1001)
libust[XXX/XXX]: Sent register event notification for name 
"ust_pthread:pthread_mutex_trylock": ret_code 0, event_id 6
  (in ustcomm_register_event() at lttng-ust-comm.c:1001)
libust[XXX/XXX]: Sent register event notification for name 
"ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 7
  (in ustcomm_register_event() at lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[XXX/XXX]: Registering probe to tracepoint 
ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at 
tracepoint.c:563)
liblttng_ust_tracepoint[XXX/XXX]: Registering probe to tracepoint 
ust_pthread:pthread_mutex_trylock (in __tracepoint_probe_register() at 
tracepoint.c:563)
liblttng_ust_tracepoint[XXX/XXX]: Registering probe to tracepoint 
ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at 
tracepoint.c:563)
liblttng_ust_tracepoint[XXX/XXX]: Registering probe to tracepoint 
ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at 
tracepoint.c:563)

As with this one, the first three lines of all registrations are always 
the same and do not match the following (in this case) 'Provider 
"ust_pthread" accepted'.
I subsequently only get tracepoint data from ust_baddr_statedump:soinfo.

I followed these build instructions for my board using Yocto 1.7: 
http://rocketboards.org/foswiki/view/Documentation/GSRD150CompilingLinux
I also tried updating the recipes to use the latest version of LTTng. 
The output above is from LTTng v2.6.2.
I can provide more debug output if that helps. I do not see this problem 
on my desktop computer.

Can somebody confirm this problem?

Thanks, Christian
