From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: memory leak when UST
 events are enabled with exclusions
Date: Tue, 4 Feb 2014 14:15:16 -0500
Message-ID: <20140204191516.GJ13440__40651.0529145182$1391541577$gmane$org@thessa>
References: <1390240272-16029-1-git-send-email-jeremie.galarneau@efficios.com>
	<1633494270.16038.1391122775911.JavaMail.zimbra@efficios.com>
	<CAJ7wx-Fz9cBNpMoUz61uA=pi0FL09qj3a60prSRMqOLjyPpezw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319688174=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WAlSv-0000vy-Er
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 14:15:34 -0500
In-Reply-To: <CAJ7wx-Fz9cBNpMoUz61uA=pi0FL09qj3a60prSRMqOLjyPpezw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0319688174==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 31 Jan (22:38:51), Zifei Tong wrote:
> I have to apply this patch onto J=E9r=E9mie's one to bypass a double free
> error in unit test.
>=20
> diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> index 52b93e9..92f8771 100644
> --- a/tests/unit/test_ust_data.c
> +++ b/tests/unit/test_ust_data.c
> @@ -172,7 +172,6 @@ static void test_create_ust_event_exclusion(void)
>            event->attr.name[LTTNG_UST_SYM_NAME_LEN - 1] =3D=3D '\0',
>            "Validate UST event and exclusion");
>=20
> -       free(exclusion);
>         trace_ust_destroy_event(event);
>  }
>=20
> --
> Best Regards,
> Zifei Tong
>=20
>=20
> On Fri, Jan 31, 2014 at 6:59 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > David: this needs to be merged.
> >
> > Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > Thanks,
> >
> > Mathieu
> >
> > ----- Original Message -----
> >> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
> >> To: lttng-dev@lists.lttng.org
> >> Sent: Monday, January 20, 2014 12:51:12 PM
> >> Subject: [lttng-dev] [PATCH lttng-tools] Fix: memory leak when UST eve=
nts     are enabled with exclusions
> >>
> >> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> >> ---
> >>  src/bin/lttng-sessiond/trace-ust.c | 1 +
> >>  src/bin/lttng-sessiond/trace-ust.h | 2 +-
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/src/bin/lttng-sessiond/trace-ust.c
> >> b/src/bin/lttng-sessiond/trace-ust.c
> >> index 70b3a91..c08246a 100644
> >> --- a/src/bin/lttng-sessiond/trace-ust.c
> >> +++ b/src/bin/lttng-sessiond/trace-ust.c
> >> @@ -504,6 +504,7 @@ void trace_ust_destroy_event(struct ltt_ust_event =
*event)
> >>
> >>       DBG2("Trace destroy UST event %s", event->attr.name);
> >>       free(event->filter);
> >> +     free(event->exclusion);
> >>       free(event);
> >>  }
> >>
> >> diff --git a/src/bin/lttng-sessiond/trace-ust.h
> >> b/src/bin/lttng-sessiond/trace-ust.h
> >> index f2f8c7e..07af0f1 100644
> >> --- a/src/bin/lttng-sessiond/trace-ust.h
> >> +++ b/src/bin/lttng-sessiond/trace-ust.h
> >> @@ -50,7 +50,7 @@ struct ltt_ust_event {
> >>       struct lttng_ust_event attr;
> >>       struct lttng_ht_node_str node;
> >>       struct lttng_ust_filter_bytecode *filter;
> >> -     const struct lttng_event_exclusion *exclusion;
> >> +     struct lttng_event_exclusion *exclusion;
> >>  };
> >>
> >>  /* UST channel */
> >> --
> >> 1.8.5.2
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS8TxEXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02J7AIAJAatxMfbG3TVZ/bpk4ei66o
y/ntaZtDekqfw873CVv82oCGgXySaR4Ql5rH6fCEHfgDz2t6moP+3crIhB4p5pKT
bFSlFjjdO3xvyaNasn86Zfa35sQHqxetFEjm9XGav22Alal+fJH4D5V6DzzfKKo2
vZv1yfc6nKppT/bRCdi4aM+Y0dPQhDKk1vls3tSwoWp4pV8e2vB+aBeT22fV3TnU
fpWPnS89nedB7uIYMxj9dalPaWOcxeiVGllEaSNTlQSAj/peNjYBcSqK0k4hhOOy
NnTpeJpinqTR0CLYqiBfZiKUb4rFkqGkFQakAaVCtytvF7bWa2ZWNb2NrLPQU8s=
=LZRx
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--


--===============0319688174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0319688174==--
