From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Tue, 6 Sep 2016 04:20:18 +0900
Message-ID: <20160906042018.dd1e1dc6df8de1e1ebb38a50@kernel.org>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
	<20160818105424.GD4850@stefanha-x1.localdomain>
	<8737lypajh.fsf@fimbulvetr.bsc.es>
	<20160823155430.GB3948@stefanha-x1.localdomain>
	<87lgzm4g5p.fsf@fimbulvetr.bsc.es>
	<20160829134502.GA26282@stefanha-x1.localdomain>
	<87a8fvjtw5.fsf@fimbulvetr.bsc.es>
	<20160831163547.GD18281@stefanha-x1.localdomain>
	<87y436mn02.fsf@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <87y436mn02.fsf@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: =?UTF-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org

On Mon, 05 Sep 2016 16:37:01 +0200
Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:

> Stefan Hajnoczi writes:
>=20
> > On Mon, Aug 29, 2016 at 08:46:02PM +0200, Llu=C3=ADs Vilanova wrote:
> >> >> Also, I'm still not sure how to interact with QEMU's monitor inte=
rface from
> >> >> within the probe code (probes execute in kernel mode, including "=
guru mode"
> >> >> code).
> >>=20
> >> > When SystemTap is used the QEMU monitor interface does nothing.
> >>=20
> >> That's not what I've experienced. I was able to use a stap script to=
 change the
> >> tracing state of events:
> >>=20
> >> #!/usr/bin/env stap
> >>=20
> >> %{
> >> #include </home/lluis/Projects/qemu-dbi-test/test.h>
> >> %}
> >>=20
> >> function event:long(cpu:long, addr:long, info:long)
> >> %{
> >> char *argv[4] =3D {"/bin/sh", "-c", "echo 'trace-event * off' | teln=
et localhost 1234", NULL};
> >> call_usermodehelper(argv[0], argv, NULL, UMH_WAIT_EXEC);
> >> STAP_RETURN(0);
> >> %}
> >>=20
> >> probe begin {
> >> printf("hello\n")
> >> }
> >> probe process("./install/vanilla/bin/qemu-system-i386").mark("guest_=
mem_before_exec")
> >> {
> >> printf("%x %d %d\n", $arg1, $arg2, $arg3)
> >> event($arg1, $arg2, $arg3)
> >> exit()
> >> }
> >>=20
> >> The only caveat is that you must pass the "-g" argument to stap.
> >>=20
> >> Also, for some reason the printf in the probe always prints zeros, n=
o matter
> >> what the actual event receives (I've debugged QEMU down to the call =
to the
> >> auto-generated stap functions). Could this be an error in systemtap?
>=20
> > It's strange that arguments do not have valid values.  Debugging the
> > stap functions is the next step if you want to figure out what happen=
ed.
> > I've never had this issue before so maybe something with Debian
> > SystemTap userspace probes is broken.
>=20
> I already debugged it, to the point where QEMU executes the trap inject=
ed by
> systemtap, and the register values that were supposed to hold the argum=
ents are
> correct.
>=20
> I suppose that if you execute the stap script I pasted it will show the=
 proper
> values. Then it's definitely a problem with Debian's userspace probes.

Would you have tried to update your kernel to mainline and tested it ?
If it occurs, you also should try to use a raw uprobe via ftrace(uprobe_e=
vents)
and perftools.
If you have the latest perf (maybe you'll need checkout the latest tip tr=
ee),
you can use SDT as below (currently it doesn't support args, so you'll ne=
ed
debuginfo.)

# perf buildid-cache --add ./install/vanilla/bin/qemu-system-i386
# perf probe -x ./install/vanilla/bin/qemu-system-i386 -a 'guest_mem_befo=
re_exec $vars'

And you'll see new event is registered which can be traced by ftrace or p=
erf.

Thanks,

--=20
Masami Hiramatsu <mhiramat@kernel.org>
