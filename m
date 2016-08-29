From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Mon, 29 Aug 2016 09:45:02 -0400
Message-ID: <20160829134502.GA26282@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
	<20160818105424.GD4850@stefanha-x1.localdomain>
	<8737lypajh.fsf@fimbulvetr.bsc.es>
	<20160823155430.GB3948@stefanha-x1.localdomain>
	<87lgzm4g5p.fsf@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <87lgzm4g5p.fsf@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 12:25:54PM +0200, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Sun, Aug 21, 2016 at 02:32:34PM +0200, Llu=EDs Vilanova wrote:
> >> Unfortuntely, I've been unable to to make dtrace recognise QEMU's even=
ts (I'm
> >> only able to see the host kernel events). If someone with more experie=
nce on it
> >> can help me use dtrace with QEMU's events, I'll also add the supportin=
g library
> >> to let dtrace do the callout to QEMU's moitor interface and control th=
e events,
> >> and add a prperly useful example of that on the hypertrace docs (which=
 was my
> >> original intention).
>=20
> > Which "dtrace" and host OS are you using?
>=20
> > QEMU builds with static user-space probes.  You need to tell DTrace or
> > SystemTap to enable those probes in order to record trace data.
>=20
> I'm using debian on a 4.6.0-1-amd64 kernel with systemtap 3.0.6.
>=20
> I just gave it another try, and works if I use probes like:
>=20
>   process("<binary-path>").mark("<event-name>")
>=20
> although they don't seem to appear on "stap -l" or anything like that (I =
cannot
> find a "qemu" provider). But I'm still unable to print the event values. =
This:

The following enumerates events for me:

$ sudo stap -L 'process("/usr/bin/qemu-system-x86_64").mark("*")'
process("/usr/bin/qemu-system-x86_64").mark("alsa_no_frames") $arg1:long
process("/usr/bin/qemu-system-x86_64").mark("alsa_pollout") $arg1:long $arg=
2:long
process("/usr/bin/qemu-system-x86_64").mark("alsa_read_zero") $arg1:long
=2E..

You can also use /usr/share/systemtap/tapset/qemu-system-x86_64.stp.
I'm running Fedora 24 with qemu-system-x86 2.6.0-5.fc24 and SystemTap
3.0-3.fc24.

> Also, I'm still not sure how to interact with QEMU's monitor interface fr=
om
> within the probe code (probes execute in kernel mode, including "guru mod=
e"
> code).

When SystemTap is used the QEMU monitor interface does nothing.

Stefan

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXxDxeAAoJEJykq7OBq3PIOgEH+wRgmT8atWscf8iNHqK++G1l
3g0e2ar42zxQq3fhtG7wW0/m24pFeyQs6MkPFEZuQ/kPDdnfo02lSk64IkMQ31gS
YOdFS0M0zE6e/4lrBI+4T2thvvj2RxpgbefrrBIbyElAUi9NuMCSQxh8/kuW9Q/A
58VUsLVCs7Hu2/bRjCN2qsjG6u+df7NL2dszhUGxkLC7XfFLzOkv6zPB3zFQaJYS
ip+8n0L+krysAM+e8ZVvq4fJDLkgVWT/iRHatUs2GYqjYrpwobXo4sfdNoDryAz8
ZzOR0x0jnWsd40kcypP+IWj1+XLg9SrVuvmPinCui7qp1jAovg0du2Q0VC5X0LA=
=NwMs
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
