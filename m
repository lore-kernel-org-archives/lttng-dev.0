From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add vpid,
 vppid and vtid explanation in add-context help menu
Date: Thu, 19 Jun 2014 14:41:53 -0400
Message-ID: <20140619184153.GB27213__29540.2415482842$1403203382$gmane$org@thessa>
References: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
 <20140619182119.GA27213@thessa>
 <CADcCL0giSreZ=bmPC+Q9jcNrsqkPSnoR92RTQ2X-iVP7Kf=zmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1028017917=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WxhHc-0001Sk-Nl
 for lttng-dev@lists.lttng.org; Thu, 19 Jun 2014 14:42:05 -0400
In-Reply-To: <CADcCL0giSreZ=bmPC+Q9jcNrsqkPSnoR92RTQ2X-iVP7Kf=zmA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1028017917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Jun (14:38:52), Francis Deslauriers wrote:
> On Thu, Jun 19, 2014 at 2:21 PM, David Goulet <dgoulet@efficios.com> wrot=
e:
> > On 18 Jun (22:19:40), francis.deslauriers@efficios.com wrote:
> >> From: Francis Deslauriers <francis.deslauriers@efficios.com>
> >>
> >> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> >> ---
> >>  src/bin/lttng/commands/add_context.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/comm=
ands/add_context.c
> >> index 405b782..52d0db4 100644
> >> --- a/src/bin/lttng/commands/add_context.c
> >> +++ b/src/bin/lttng/commands/add_context.c
> >> @@ -514,6 +514,9 @@ static void usage(FILE *ofp)
> >>       fprintf(ofp, "                           TYPE can be one of the =
strings below:\n");
> >>       print_ctx_type(ofp);
> >>       fprintf(ofp, "\n");
> >> +     fprintf(ofp, "Note that the vpid, vppid and vtid context types r=
epresent the virtual process id,\n"
> >> +                     "virtual parent process id and virtual thread id=
 as seen from the current execution context\n"
> >> +                     "as oppose to the pid, ppid and tid that are ker=
nel internal data structures.\n\n");
> >
> > That would be kind of neat if you could also add this to the man page.
> > Usually, I try to keep both the --help and man page in sync :).
>=20
> I didn't add it to the man page because there is no mention of the
> available context types in the man page.
> The user is asked to run the lttng add-context -h command to get more
> information on the available types.
> Should I add a note to the man page anyway?

Oh! Fair enough, that's all fine.

I'll merge this in a jiffy.

Thanks!
David

>=20
> Thanks,
> Francis
>=20
> >
> > Cheers!
> > David
> >
> >>       fprintf(ofp, "Example:\n");
> >>       fprintf(ofp, "This command will add the context information 'pri=
o' and two per-cpu\n"
> >>                       "perf counters (hardware branch misses and cache=
 misses), to all channels\n"
> >> --
> >> 1.8.3.2
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJToy7xXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02bsYH/jHLvjggGGNoU9ZcUKygyec7
r0wZ5nPkiVLi0t4Q9yLMYYxF6ydZQH+PvQC/OG5COToF0Zbai4ELsTlnu6ImfP0k
L4YTDjlQ4EFCtqnVVFAjo0VuXOOtkyiH3obTLlfAfw0couY4UafIP5xgoBIrmyIj
1mmSwNJFE1hMN1Qd3TGzr6cBAnKqjjoYW/OUtOxfmJdY8NisVVe0/zT9gSFAKTIi
esKP6qT+K0l37rtZ81fWSBcl+ufX9B+ypgJaUjZaSDIQDrSfaBDXtQxy+EAcpWMi
kh/ldnjpQXAfABNj5dSFnzcpAgS2Jd7jXaPdd6mP+sHlTEBMLNAdY1G5AOYSG/s=
=o2At
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


--===============1028017917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1028017917==--
