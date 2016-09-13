From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Tue, 13 Sep 2016 14:52:50 +0100
Message-ID: <20160913135250.GA4024@stefanha-x1.localdomain>
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
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
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
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: lttng-dev@lists.lttng.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 04:37:01PM +0200, Llu=EDs Vilanova wrote:
> I suppose that if you execute the stap script I pasted it will show the p=
roper
> values. Then it's definitely a problem with Debian's userspace probes.

Sorry for the delay.  SystemTap static probes appear to work correctly on
Fedora 24.

I built qemu.git/master from source with "--enable-trace-backends=3Ddtrace"=
 and
tried the following:

$ rpm -qi systemtap kernel-devel | grep Source
Source RPM  : systemtap-3.0-3.fc24.src.rpm
Source RPM  : kernel-4.7.2-201.fc24.src.rpm

(By the way, I hit the same mutex_lock() vs inode_lock() issue in systemtap=
 as you.)

$ cat test.stp
probe begin {
	printf("hello\n");
}

probe process("path/to/qemu-system-x86_64").mark("kvm_ioctl")
{
	printf("%x %p\n", $arg1, $arg2)
}

$ sudo stap test.stp -c 'path/to/qemu-system-x86_64 -enable-kvm -m 1024'
hello
ae00 0x0
ae03 0xa
ae03 0x9
ae03 0x42
ae01 0x0

These are valid argument values.  What happens on your Debian box?

Stefan

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJX2ASyAAoJEJykq7OBq3PIgucIAIVgE6v6+MNCDRbPxmuN2khB
bZI0dKDqevKy+/SdkTNafsBqr71H/gl0wDA7CwsAFzAp21grSJ+p7+hR2pgAFm3K
sd09/s5XHVF7N1fp5uPH8NwrmvsPghhTD0392S7wAli3t+z9wOq0j9zRjl2/uBxg
ktdkejoF6rp+mQHJXPkcEIGKvQ8F3mwSxcSe4ukQWDMZp42KMWuH7dTxZ9EeUkt/
jyCNQXRrIi2Q0lWcP0gMTZrg57669AT9Cyfld0Z0/yn4uC5U1HyM5ALYe3Ly8zlL
ThgbhhYZBph+GMn/8+oXj97WIbQ94cjO8J6Af3oYtB4Q+WFIUWYtL/sbAoHqL/I=
=vhEj
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
