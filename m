From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Scope of event names?
Date: Thu, 14 Feb 2013 21:32:51 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD016655__11468.7265981503$1360877653$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U66Qa-0002q2-1y
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 16:33:12 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

   I'm operating under the assumption that an event's "fully qualified" ide=
ntifier is something like session:domain:channel:name.  Tracepoints and sys=
calls have system-defined names, and of course the domain can only be 'kern=
el' or 'userspace', but everything else is pretty much arbitrary.  My hypot=
hesis is thus that, as long as they're in different channels (or domains or=
 possibly sessions), two events may bear the same name even though they rep=
resent completely different occurrences.  So here's what I did (lttng list =
output has been abridged), with comments interspersed:

$ sudo -H lttng create asession
Session asession created.
Traces will be written in /root/lttng-traces/asession-20130214-145626
$ sudo -H lttng enable-event sched_switch -k --tracepoint
kernel event sched_switch created in channel channel0
$ sudo -H lttng enable-event sched_switch -k --function lttng_calibrate_kre=
tprobe --channel channel1
Error: Event sched_switch: Enable kernel event failed (channel channel1, se=
ssion asession)
Warning: Some command(s) went wrong
/*
 Okay, so maybe event names have session:domain scope. Let's test this.
 */
$ sudo -H lttng enable-event fevent -k --function lttng_calibrate_kretprobe=
 --channel channel1
kernel event fevent created in channel channel1
$ sudo -H lttng enable-event fevent -k --function lttng_calibrate_kretprobe=
 --channel channel2
kernel event fevent created in channel channel2
/*
 Apparently not.
 */
$ sudo -H lttng list asession
Tracing session asession: [inactive]
=3D=3D=3D Domain: Kernel =3D=3D=3D
- channel2: [enabled]
    Events:
      fevent (type: probe) [enabled]
        offset: 0x0
        symbol: lttng_calibrate_kretprobe
- channel1: [enabled]
    Events:
      fevent (type: probe) [enabled]
        offset: 0x0
        symbol: lttng_calibrate_kretprobe
- channel0: [enabled]
    Events:
      sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]
/*
 Instead of tracepoint then function, let's try function then tracepoint
 */
$ sudo -H lttng enable-event sched_process_fork -k --function lttng_calibra=
te_kretprobe --channel channel3
kernel event sched_process_fork created in channel channel3
$ sudo -H lttng enable-event sched_process_fork -k
kernel event sched_process_fork created in channel channel0
$ sudo -H lttng enable-event sched_process_fork -k --function lttng_calibra=
te_kretprobe --channel channel4
Error: Event sched_process_fork: Enable kernel event failed (channel channe=
l4, session asession)
Warning: Some command(s) went wrong
/*
 Fascinating.
 */
$ sudo -H lttng list asession
Tracing session asession: [inactive]
- channel3: [enabled]
    Events:
      sched_process_fork (type: probe) [enabled]
        offset: 0x0
        symbol: lttng_calibrate_kretprobe
- channel2: [enabled]
    Events:
      fevent (type: probe) [enabled]
        offset: 0x0
        symbol: lttng_calibrate_kretprobe
- channel1: [enabled]
    Events:
      fevent (type: probe) [enabled]
        offset: 0x0
        symbol: lttng_calibrate_kretprobe
- channel0: [enabled]
    Events:
      sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint) [en=
abled]
      sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint) [enabled]

   At this point it looks like defining a kernel tracepoint prevents that t=
racepoint's name from being used in other channels to define other events (=
or even the same event).  But nothing apparently prevents these other event=
s from being set up *before* the tracepoint.  (Not shown here is the case w=
here a tracepoint is defined in one channel, and then in another: the secon=
d tracepoint event definition fails as well)

   Can anyone shed light on this?  (Note that I haven't even tried yet to s=
ee what happens between simultaneous sessions...)

   The control flow of the error-causing commands is something like:

event.c's event_kernel_enable_tracepoint returns LTTNG_ERR_KERN_ENABLE_FAIL=
 because
kernel.c's kernel_create_event gets something else than ENOSYS or EEXIST fr=
om
kernel-ctl.c's kernctl_create_event =


   Beyond kernctl_create_event is debugfs, inside of which occurs...whateve=
r.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
