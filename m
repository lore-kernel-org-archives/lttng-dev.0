From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Subject: Re: LTTng 2.5 save/load feature feedback
Date: Wed, 2 Jul 2014 09:56:29 -0400
Message-ID: <53B40F8D.3090002__8277.90914704583$1404309450$gmane$org@ericsson.com>
References: <5388A99A.9000506@efficios.com> <20140602155027.GB7936@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1X2L1Y-0005Y8-Qp
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 09:56:40 -0400
In-Reply-To: <20140602155027.GB7936@thessa>
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

Hi J=E9r=E9mie,David

While working on tests for the machine interface I had some fun debugging t=
hat I had more sessions destroyed then intended.
It took me a good 15 mins to have an eureka moment and remember this thread=
. =


It might be a good idea to add an argument to lttng-sessiond to prevent the=
 loading of auto-sessions.
This would help a lot in testing to ensure an independent testing environme=
nt. There ways to walk around it but I feel that we should not use workarou=
nds to get a clean test environment.

What do you think?

(Sorry J=E9r=E9mie I should have read the RFC :) )

On 06/02/2014 11:50 AM, David Goulet wrote:
> On 30 May (11:54:02), Julien Desfossez wrote:
>> Hi,
>>
>> I recently tried the new save/load feature and I have some feedback I'd
>> like to share.
>>
>> My understanding was that I could create some kind of profile for
>> complex tracing setups. Lttngtop is a good example, because we have a
>> specific set of events and contexts to enable (to avoid doing -k -a).
>> So as my normal user (part of the tracing group and with a sessiond
>> started as root), I created a typical lttngtop session like that :
>>
>> lttng create lttngtop
>> lttng enable-event -k
>> lttng_statedump_start,lttng_statedump_end,lttng_statedump_process_state,=
lttng_statedump_file_descriptor,lttng_statedump_vm_map,lttng_statedump_netw=
ork_interface,lttng_statedump_interrupt,sched_process_free,sched_switch,sch=
ed_process_fork
>> -s lttngtop
>> lttng enable-event -k --syscall -a -s lttngtop
>> lttng add-context -k -t pid -t procname -t tid -t ppid -t
>> perf:cache-misses -t perf:major-faults -t perf:branch-load-misses -s
>> lttngtop
>> lttng save lttngtop
>>
>> I then destroyed the session and did
>> lttng load lttngtop
>>
>> Everything went fine (except for the already known bug of all the
>> contexts information not recorded in the XML file). As expected, the XML
>> file was saved in ~/.lttng/sessions/lttngtop.lttng.
>>
>> What surprised me was to see this message when later on I started
>> manually a lttng-sessiond as my user (after it had been killed) :
>> Error: Failed to load session lttngtop: Tracing the kernel requires a
>> root lttng-sessiond daemon, as well as "tracing" group membership or
>> root user ID for the lttng client.
>> Error: Session load failed: Tracing the kernel requires a root
>> lttng-sessiond daemon, as well as "tracing" group membership or root
>> user ID for the lttng client.
>>
>> I did not expect that the saved sessions would try to auto load when the
>> sessiond was starting. I did not try with system-wide sessions, but
>> that's the same, I don't really expect that all sessions to be
>> automatically loaded on startup. I think a sysadmin (or even the lttng
>> installer) could make some tracing profiles available to the users in
>> there so that they can use them when needed.
>> Also, the fact that a user sessiond tries to load a session that clearly
>> requires a root sessiond is kind of confusing.
>>
>> I can see the value of having auto-loaded sessions, but I think it
>> should be configurable, either directly in the XML (just like to
>> "started" option) or with sessions saved in a different path (for
>> example ~/.lttng/auto-sessions/). Also, I think that our users are never
>> really spawning manually a sessiond, so maybe the "lttng load -a" is
>> more suited for the auto-loading process.
> =

> I agree with you on the auto load issue and that we might want to have
> something like that (=E0 la Apache):
> =

> ~/.lttng/sessions/auto/
> =

> Have symlink/copy of the session file that you want loaded automatically
> in that directory.
> =

>>
>> So we could maybe add an option to the "lttng save" command that allows
>> the user to specify if the session should be auto-loaded.
> =

> Yes. Maybe a long --auto or -A ?
> =

>> With that in mind, should the users part of the tracing group allowed
>> to save auto-loading kernel sessions in the system-wide tracing
>> directory, or will they have to ask an admin to manually install their
>> profile ?
> =

> I would say yes here because one can create a kernel session like you do
> with lttngtop, a lot of events/contexts then save it in let say a lttng
> session template repository or feed it to an other session daemon on an
> other system.
> =

> One thing we could do is to be more clever during the load and return an
> error directly in the liblttng-ctl instead of the round trip to the
> session daemon.
> =

> If we agree on the above, opening issues on bugs.lttng.org would be the
> next step so we can fix these for 2.5 stable.
> =

> Cheers!
> David
> =

>>
>> I apologize for not providing this kind of feedback when the RFC was
>> posted here, I just realized these usability details when I actually
>> experimented the feature.
>>
>> Thanks,
>>
>> Julien
>>
>> _______________________________________________ lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
