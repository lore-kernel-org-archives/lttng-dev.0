From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Better error reporting when a
 snapshot record size is too small
Date: Tue, 15 Apr 2014 11:16:00 -0400
Message-ID: <20140415151600.GC7829__49751.2146867395$1397575046$gmane$org@thessa>
References: <1397572329-7168-1-git-send-email-jeremie.galarneau@efficios.com>
 <20140415144408.GB7829@thessa>
 <CA+jJMxsHrHiMGm2Vi5mm5D=AY4OnexSd8V-MUxe65FpVNJ7fXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1130847833=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wa55p-00021r-0u
 for lttng-dev@lists.lttng.org; Tue, 15 Apr 2014 11:16:18 -0400
In-Reply-To: <CA+jJMxsHrHiMGm2Vi5mm5D=AY4OnexSd8V-MUxe65FpVNJ7fXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1130847833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Apr (11:14:18), J=E9r=E9mie Galarneau wrote:
> On Tue, Apr 15, 2014 at 10:44 AM, David Goulet <dgoulet@efficios.com> wro=
te:
> > On 15 Apr (10:32:09), J=E9r=E9mie Galarneau wrote:
> >> Print an error message when a snapshot record is made with a
> >> max size smaller than the subbuffers. This limitation is now
> >> documented in the man page.
> >
> > Why is this not done on the session daemon side? Like "Oh you provided
> > me with a wrong max size" type of error message.
> >
> > Because here this fixes the issue only on the command line side but a
> > user using the API would still fail somehow silently or ... ?
> >
>=20
> The API call could return something like
> -LTTNG_ERR_SNAPSHOT_TOO_SMALL... It sure would be better than what we
> have now (a DBG3(...) message on the sessiond side).
>=20
> > Not that I don't like the approach here but I just need to know if there
> > is a specific reason it's done on the lttng client side only. This patch
> > adds two calls that can exchange quite a bit of data with the sessiond
> > (list domains and channels) so unless there is no other way, I would go
> > for a sessiond side validation instead.
> >
>=20
> Well, I think clients will end up implementing the same logic
> anyway... If the record call fails because the max size is too small,
> API users will query the sessiond to know what size would fit.
> Ideally, the lttng client will also report the smallest suitable size
> in the error message (like it does in my patch).
>=20
> I understand your concern about data exchanges delaying the snapshot,
> though. What I'd propose is to report the new -LTTNG_ERR_SNAPSHOT_...
> code from the API, and have the client report the smallest size
> possible size to the user using get_largest_subbuf() when such an
> error occurs. What do you think?

Perfect solution for me!

David

>=20
> Thanks,
> J=E9r=E9mie
>=20
> > Cheers!
> > David
> >
> >>
> >> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> >> ---
> >>  doc/man/lttng.1                   |  4 ++-
> >>  src/bin/lttng/commands/snapshot.c | 59 ++++++++++++++++++++++++++++++=
+++++++++
> >>  2 files changed, 62 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> >> index 972f71c..bf1b67e 100644
> >> --- a/doc/man/lttng.1
> >> +++ b/doc/man/lttng.1
> >> @@ -787,7 +787,9 @@ List the output of a session. Attributes of the ou=
tput are printed.
> >>  Snapshot a session's buffer(s) for all domains. If an URL is specifie=
d, it is
> >>  used instead of a previously added output. Specifying only a name or/=
and a max
> >>  size will override the current output values. For instance, you can r=
ecord a
> >> -snapshot with a custom maximum size or with a different name.
> >> +snapshot with a custom maximum size or with a different name. However=
, the
> >> +max size must be high enough to contain a complete subbuffer. See the
> >> +--subbuf-size switch for default subbuffer sizes.
> >>
> >>  .nf
> >>  $ lttng snapshot add-output -n mysnapshot file:///data/snapshot
> >> diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/command=
s/snapshot.c
> >> index c704eee..7fda949 100644
> >> --- a/src/bin/lttng/commands/snapshot.c
> >> +++ b/src/bin/lttng/commands/snapshot.c
> >> @@ -125,6 +125,56 @@ static int count_arguments(const char **argv)
> >>       return i;
> >>  }
> >>
> >> +static uint64_t get_largest_subbuf()
> >> +{
> >> +     int domain_count;
> >> +     int channel_count;
> >> +     int domain_idx;
> >> +     int channel_idx;
> >> +     struct lttng_domain *domains;
> >> +     uint64_t largest_subbuf =3D 0;
> >> +
> >> +     domain_count =3D lttng_list_domains(current_session_name, &domai=
ns);
> >> +     if (domain_count < 0) {
> >> +             ERR("Unable to list session %s's domains",
> >> +                     current_session_name);
> >> +             goto end;
> >> +     }
> >> +
> >> +     for (domain_idx =3D 0; domain_idx < domain_count; domain_idx++) {
> >> +             struct lttng_channel *channels;
> >> +             struct lttng_handle *handle =3D lttng_create_handle(
> >> +                     current_session_name, &domains[domain_idx]);
> >> +
> >> +             if (!handle) {
> >> +                     ERR("Unable to create handle for session %s",
> >> +                             current_session_name);
> >> +                     goto end;
> >> +             }
> >> +
> >> +             channel_count =3D lttng_list_channels(handle, &channels);
> >> +             if (channel_count < 0) {
> >> +                     ERR("Unable to list channels for session %s",
> >> +                             current_session_name);
> >> +                     goto end;
> >> +             }
> >> +
> >> +             for (channel_idx =3D 0; channel_idx < channel_count;
> >> +                     channel_idx++) {
> >> +                     if (channels[channel_idx].attr.subbuf_size >
> >> +                             largest_subbuf) {
> >> +                             largest_subbuf =3D
> >> +                                     channels[channel_idx].attr.subbu=
f_size;
> >> +                     }
> >> +             }
> >> +             free(channels);
> >> +             lttng_destroy_handle(handle);
> >> +     }
> >> +end:
> >> +     free(domains);
> >> +     return largest_subbuf;
> >> +}
> >> +
> >>  /*
> >>   * Create a snapshot output object from arguments using the given URL.
> >>   *
> >> @@ -160,6 +210,15 @@ static struct lttng_snapshot_output *create_outpu=
t_from_args(const char *url)
> >>       }
> >>
> >>       if (opt_max_size) {
> >> +             /* Validate that the max size can contain one subbuffer.=
 */
> >> +             uint64_t largest_subbuf =3D get_largest_subbuf();
> >> +             if (largest_subbuf =3D=3D 0) {
> >> +                     goto error;
> >> +             } else if (largest_subbuf > opt_max_size) {
> >> +                     ERR("Snapshot size must be greater or equal to t=
he largest subbuffer's size (%zu).",
> >> +                             largest_subbuf);
> >> +                     goto error;
> >> +             }
> >>               ret =3D lttng_snapshot_output_set_size(opt_max_size, out=
put);
> >>               if (ret < 0) {
> >>                       goto error;
> >> --
> >> 1.9.1
> >>
>=20
>=20
>=20
> --=20
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTTU0wXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ql0IAK46+cn7vrDeKO2m5hJ6Yvxi
5q5DC+B1SBpxqIklCWkOe7ehsRABVoiu50JXYvCQ71Y5j9a9EhoVlHwWB9smon8G
dNRS55KWzcEMheJKp1ddN6qML44St4bcS7y5bL0qXpwpqfUMWITHnxhNBl/FbJJN
ozIv0PkIileDIhKT1/PlJz8C7gHrOWkqN/rRb4DNFP70dv/QeCiaDBK5raCL0J2O
XqfmlMR0RsyZvKec+jexiIEqnZnMSYluuwk5drxhmyRdcSZLiSBctN6862/Px3s3
wYx12Ntbs6qzUPlyuZkB31i1QJDm91Heza2xWwfN8toWF71/19qBqNfdundD1Hg=
=77T2
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--


--===============1130847833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1130847833==--
