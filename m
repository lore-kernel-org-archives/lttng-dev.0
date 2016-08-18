From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Thu, 18 Aug 2016 11:54:24 +0100
Message-ID: <20160818105424.GD4850@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2016 at 06:59:23PM +0200, Llu=EDs Vilanova wrote:
> The hypertrace channel allows guest code to emit events in QEMU (the host=
) using
> its tracing infrastructure (see "docs/trace.txt"). This works in both 'sy=
stem'
> and 'user' modes. That is, hypertrace is to tracing, what hypercalls are =
to
> system calls.
>=20
> You can use this to emit an event on both guest and QEMU (host) traces to=
 easily
> synchronize or correlate them. You could also modify you guest's tracing =
system
> to emit all events through the hypertrace channel, providing a unified an=
d fully
> synchronized trace log. Another use case is timing the performance of gue=
st code
> when optimizing TCG (QEMU traces have a timestamp).
>=20
> See first commit for a full description.

This tracing approach has a high performance overhead, particularly for
SMP guests where each trace event requires writing to the global control
register.  All CPUs will be hammering this register (heavyweight vmexit)
for each trace event.

I think the folks CCed on this email all take an asynchronous approach
to avoid this performance overhead.  Synchronous means taking a VM exit
for every event.  Asynchronous means writing trace data to a buffer and
later interleaving guest data with host trace data.

LTTng Userspace Tracer is an example of the asynchronous approach.  The
trace data buffers are in shared memory.  The LTTng process can grab
buffers at appropriate times.

The ftrace virtio-serial approach has been to splice() the ftrace
buffers, resulting in efficient I/O.

Steven is working on a host/guest solution for trace-cmd.  It is also
asynchronous.  No new paravirt hardware is needed and it makes me wonder
whether the hypertrace PCI device is trying to solve the problem at the
wrong layer.

If you want to play around with asynchronous tracing, you could start
with trace/simple.c.  It has a trace buffer that is asynchronously
written out to file by a dedicated "writer" thread.

The one case where hypertrace makes sense to me is for -user tracing.
There QEMU can efficiently interleave guest and QEMU traces, although as
mentioned in the patch, I don't think the SIGSEGV approach should be
used.

I suggest stripping this series down to focus on -user.  Synchronous
tracing is not a good approach for -system emulation.

Stefan

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXtZPgAAoJEJykq7OBq3PInLoH/j0Y0mw1eSOhhfRXiqu/Zp5C
URbDbBZ5Z2vYytLZIiRcm/69GKr9QJSSLj0ZoV54Er/60pFs2kxgZnsVd94oybGI
P7PqRTAiVnxI3fJJnjxfA35ox8Pl9rpK2Qila44bGypl7JK9vGZ9hrfPYDIlDseY
jO4v+1C1Z7F4nR9q5/apKtzl1JGdejUU2xmf1NlXhQ5KGOVisp0cfG2OV0sS8Sdu
hZuXJNSpVfAgPqgKpHPCzUEHZ0Zqw+G1gg2QjlDg+ladi+fv3eSZyt/opZTKky3+
hqGP47Z6CTY7cPwkhyECvoed/8McxgqbZaumqB7Yhy2sV/4BRrjyaiIqcnyBCR0=
=sD3+
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
