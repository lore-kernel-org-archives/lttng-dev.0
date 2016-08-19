From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Fri, 19 Aug 2016 13:45:31 +0900
Message-ID: <20160819134531.6e7c4099e52ba115413ee540@kernel.org>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
	<20160818105424.GD4850@stefanha-x1.localdomain>
	<20160818093711.6f77c30b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20160818093711.6f77c30b@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org

On Thu, 18 Aug 2016 09:37:11 -0400
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> On Thu, 18 Aug 2016 11:54:24 +0100
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> > On Fri, Aug 05, 2016 at 06:59:23PM +0200, Llu=C3=ADs Vilanova wrote:
> > > The hypertrace channel allows guest code to emit events in QEMU (th=
e host) using
> > > its tracing infrastructure (see "docs/trace.txt"). This works in bo=
th 'system'
> > > and 'user' modes. That is, hypertrace is to tracing, what hypercall=
s are to
> > > system calls.
> > >=20
> > > You can use this to emit an event on both guest and QEMU (host) tra=
ces to easily
> > > synchronize or correlate them. You could also modify you guest's tr=
acing system
> > > to emit all events through the hypertrace channel, providing a unif=
ied and fully
> > > synchronized trace log. Another use case is timing the performance =
of guest code
> > > when optimizing TCG (QEMU traces have a timestamp).
> > >=20
> > > See first commit for a full description. =20
>=20
> I hate the be the one asking the stupid questions, but what's
> the problem this series solves? What are the use-cases? Why
> existing solutions don't solve this problem? How does this
> compares to existing solutions?
>=20
> > This tracing approach has a high performance overhead, particularly f=
or
> > SMP guests where each trace event requires writing to the global cont=
rol
> > register.  All CPUs will be hammering this register (heavyweight vmex=
it)
> > for each trace event.

That reminds me xenprobes.
https://www.usenix.org/legacy/event/usenix07/tech/full_papers/quynh/quynh=
.pdf

The paper also tried to implement kprobe-like feature for tracing events =
in
guest. Synchronous tracing maybe easy to read the raw trace data, but cau=
se
big slowdown. Moreover, we can merge and synchronize the data easily afte=
r
traced.

> >=20
> > I think the folks CCed on this email all take an asynchronous approac=
h
> > to avoid this performance overhead.  Synchronous means taking a VM ex=
it
> > for every event.  Asynchronous means writing trace data to a buffer a=
nd
> > later interleaving guest data with host trace data.
> >=20
> > LTTng Userspace Tracer is an example of the asynchronous approach.  T=
he
> > trace data buffers are in shared memory.  The LTTng process can grab
> > buffers at appropriate times.
> >=20
> > The ftrace virtio-serial approach has been to splice() the ftrace
> > buffers, resulting in efficient I/O.
>=20
> Yes. However, note that the virtio-serial device is only used to
> transfer the tracing data to the host. It has no role in the
> tracing process. Also, it's not required. I've been using the
> networking and it works OK as long as your tracing data is not big.

Right, the no-copy virtio-serial is for reducing the overhead as small as
possible but it also requires a special programs in both of guest and hos=
t.
(since it uses unix domain socket to transfer data without copy)
In normal case, you can just trace it as like as tracing on a remote mach=
ine
via network. That's more scalable and flexible.=20


> > Steven is working on a host/guest solution for trace-cmd.  It is also
> > asynchronous.  No new paravirt hardware is needed and it makes me won=
der
> > whether the hypertrace PCI device is trying to solve the problem at t=
he
> > wrong layer.

Thanks Steven to continue that!

Regards,

> >=20
> > If you want to play around with asynchronous tracing, you could start
> > with trace/simple.c.  It has a trace buffer that is asynchronously
> > written out to file by a dedicated "writer" thread.
> >=20
> > The one case where hypertrace makes sense to me is for -user tracing.
> > There QEMU can efficiently interleave guest and QEMU traces, although=
 as
> > mentioned in the patch, I don't think the SIGSEGV approach should be
> > used.
> >=20
> > I suggest stripping this series down to focus on -user.  Synchronous
> > tracing is not a good approach for -system emulation.
> >=20
> > Stefan
>=20


--=20
Masami Hiramatsu <mhiramat@kernel.org>
