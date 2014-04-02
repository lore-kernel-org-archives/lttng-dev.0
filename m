From: David Goulet <dgoulet@efficios.com>
Subject: Re: Minor documentation issue with 2.4.0
Date: Wed, 2 Apr 2014 12:53:29 -0400
Message-ID: <20140402165329.GD7455__238.411050713871$1396517663$gmane$org@thessa>
References: <OF651759A2.C8A68066-ONC2257CAE.00334115-C2257CAE.0033A0AF@il.ibm.com>
 <CA+jJMxvOS8zo4msc_WMcrO9F=FkVbF4RwkueuKeL=jnjWQRHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1033184291=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WVOQ2-0001MB-Nb
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 12:53:48 -0400
In-Reply-To: <CA+jJMxvOS8zo4msc_WMcrO9F=FkVbF4RwkueuKeL=jnjWQRHHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1033184291==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02 Apr (10:48:02), J=E9r=E9mie Galarneau wrote:
> Hi Amit,
>=20
> Can you open a bug against lttng-tools on bugs.lttng.org? This way
> we'll be sure to track the change.

You can't enable channel in JUL, this is one of the limitations. First,
it shouldn't mention "-j" at all in the help or man page. Second, we
should clearly document that limitation in the man page.

So yes a bug would great to state that there is some doc. missing about
JUL and channels.

Cheers!
David

>=20
> Thanks,
> J=E9r=E9mie
>=20
> On Wed, Apr 2, 2014 at 5:23 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> > Hello,
> >
> > I ran a command that included an error, and noticed that 'lttng' mentio=
ns -j
> > in --buffers-pid and --buffers-uid, but nowhere else:
> >
> > # /usr/bin/lttng enable-channel -u
> > Error: Missing channel name.
> >
> > usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]
> >
> > Options:
> >   -h, --help               Show this help
> >       --list-options       Simple listing of options
> >   -s, --session NAME       Apply to session name
> >   -k, --kernel             Apply to the kernel tracer
> >   -u, --userspace          Apply to the user-space tracer
> >
> > Channel options:
> >       --discard            Discard event when buffers are full (default)
> >       --overwrite          Flight recorder mode
> >       --subbuf-size SIZE   Subbuffer size in bytes {+k,+M,+G}
> >                                (default UST uid: 131072, UST pid: 4096,
> > kernel: 262144, metadata: 4096)
> >                                Rounded up to the next power of 2.
> >       --num-subbuf NUM     Number of subbufers
> >                                (default UST uid: 4, UST pid: 4, kernel:=
 4,
> > metadata: 2)
> >                                Rounded up to the next power of 2.
> >       --switch-timer USEC  Switch timer interval in usec
> >                                (default UST uid: 0, UST pid: 0, kernel:=
 0,
> > metadata: 0)
> >       --read-timer USEC    Read timer interval in usec.
> >                                (default UST uid: 0, UST pid: 0, kernel:
> > 200000, metadata: 0)
> >       --output TYPE        Channel output type (Values: mmap, splice)
> >                                (default UST uid: mmap, UST pid: mmap,
> > kernel: splice, metadata: mmap)
> >       --buffers-uid        Use per UID buffer (-u/-j only)
> >       --buffers-pid        Use per PID buffer (-u/-j only)
> >       --buffers-global     Use shared buffer for the whole system (-k o=
nly)
> >   -C, --tracefile-size SIZE
> >                            Maximum size of each tracefile within a stre=
am
> > (in bytes). 0 means unlimited.
> >                                (default: 0)
> >   -W, --tracefile-count COUNT
> >                            Used in conjunction with -C option, this will
> > limit the number
> >                            of files created to the specified count. 0 m=
eans
> > unlimited.
> >                                (default: 0)
> >
> > Error: Command error
> >
> > You can see these 2 lines:
> >
> >       --buffers-uid        Use per UID buffer (-u/-j only)
> >       --buffers-pid        Use per PID buffer (-u/-j only)
> >
> > But -j is not explained above.
> >
> > Amit Margalit
> > IBM XIV - Storage Reinvented
> > XIV-NAS Development Team
> > Tel. 03-689-7774
> > Fax. 03-689-7230
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>=20
>=20
>=20
> --=20
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTPECJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02XCAH/3rwDxbUP82OB7gc30MS3ACe
LiIyJklQVTvog86VE/vpT9DYWM4B8FhKPjhGpeDxdef+wL5q5fuuRXppV9tqhZ/Y
vFsJ43EckMywDMm77JdStnUilj5Hh//aBpvThbMR8P6OdisA3OZmPpTnBCEbaXjc
qSBH7aX6J2FiTthykRwiP5piqKy7YxmX280VvaGNGIhwjLq46LoIBUQQMpl5B1qn
HvXKrCLSCTufveHyGYqxuwlrqauVBgWw/EUAjGYv+Fm3+rDT3FMAWyOMc3ZgtDK1
AYV3UIsYwq8IyW6arQ+EO6h6R1Qvu7aZe1JSPHlo20Ib9Qi5aqZvIweOYeeiPFU=
=89Ne
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--


--===============1033184291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1033184291==--
