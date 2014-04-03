From: David Goulet <dgoulet@efficios.com>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Thu, 3 Apr 2014 11:06:22 -0400
Message-ID: <20140403150622.GB9339__16646.2211440832$1396537673$gmane$org@thessa>
References: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw@mail.gmail.com>
 <20140325142250.GA7702@thessa>
 <CAEEAEzVTQVNjbUVy007322WeAm1jrE50i6ePAPMaGnh5iM0KOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1588340204=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WVjDu-00016s-NS
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 11:06:40 -0400
In-Reply-To: <CAEEAEzVTQVNjbUVy007322WeAm1jrE50i6ePAPMaGnh5iM0KOw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1588340204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30 Mar (21:57:30), Sandeep K Chaudhary wrote:
> Hi David,
>=20
> Add the unit tests for the changes. Please have a look at the following
> diff for the changes in unit test file.
>=20
> 40,44d39
> <               { "0X400", 1024 },
> <               { "0x40a", 1034 },
> <               { "0X40b", 1035 },
> <               { "0x40e", 1038 },
> <               { "0X40f", 1039 },
> 55c50
> < static char *invalid_tests_inputs[] =3D { "", "-1", "k", "08", "09",
> "4611686018427387904G" };
> ---
> > static char *invalid_tests_inputs[] =3D { "", "-1", "k",
> "4611686018427387904G" };

Can you attach a diff patch to the issue please?

Use "git diff" since the default "diff" command output is a bit
unreadable for my passionate git eye :).

Thanks!
David

>=20
>=20
> Thanks and regards,
> Sandeep.
>=20
>=20
> On Tue, Mar 25, 2014 at 7:22 AM, David Goulet <dgoulet@efficios.com> wrot=
e:
>=20
> > On 21 Mar (00:22:57), Sandeep K Chaudhary wrote:
> > > Hi guys,
> > >
> > > I checked the fix suggested in the bug description and it is correct.
> > >
> > > Changing
> > >
> > > ret =3D regcomp(&regex,
> > "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
> > >
> > > to
> > >
> > > ret =3D regcomp(&regex,
> > > "^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$",
> > REG_EXTENDED);
> > >
> > > will take care of the following three problems that exist in the first
> > regex
> > >
> > >
> > >    - It accepts a leading 0 (without a following x or X) to represent=
 an
> > >    octal value, but simultaneously accepts the digits 8 and 9 in said
> > octal
> > >    value (this yields -1).
> > >    - It does not support the leading 0X hexadecimal indicator but does
> > >    support a leading 0x (see following).
> > >    - It accepts a leading 0x to represent an hexadecimal value but
> > rejects
> > >    the a..f and A..F digits in said value.
> > >
> > >
> > > Please let me know your views, and then I can submit a patch for this.
> >
> > Unfortunately I don't speak regex well enough to tell you if this is
> > absolutely correct but what you should do with your patch is add unit
> > test(s) that fix the three problems you list here.
> >
> > Most probably in:
> >
> >         tests/unit/test_utils_parse_size_suffix.c
> >
> > Cheers!
> > David
> >
> > >
> > > Thanks and regards,
> > > Sandeep.
> >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
>=20
>=20
> --=20
> Thanks and regards,
> Sandeep K Chaudhary.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTPXjuXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02LrYIAJ6nTvgPVewpCd4XSf/iqIaX
v0KtZhrAyvfhCTI5fd94+TwAiIlo5jsYhEtP+wOOwK9RdFVZVDUxW9HDWyhZExSS
3LFwij8xlt+ePSKXdyHl70SMFnbWhNK3TB8cVL/xuy4UPxwrbZ+ADIyhnEkO/s8K
M0a5u23ZvCrVmHZYxMakeHP67yeGhOeYo7xt3peD5a4tkg7TDGNAnqz/QvJvCYv/
Y6cvJ44SqZjuLBnc6K18SOkHy6ang1vF9LbKsC+G+xKBW8iEDzQKhxS/NeHW4Q07
6je7JOqjCmcYrdEzBKea7wTUB2NcE1/yA/K9PwrUHcpqm1Y3BIIoMbR6rjPmPi0=
=Y1D4
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


--===============1588340204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1588340204==--
