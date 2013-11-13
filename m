From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 00/28] UST Event exclusions
Date: Wed, 13 Nov 2013 16:07:58 -0500
Message-ID: <20131113210758.GB7694__18002.9344316155$1384376945$gmane$org@dalia>
References: <1383819403-6386-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1273221413=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VghfT-00067x-EA
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 16:08:13 -0500
In-Reply-To: <1383819403-6386-1-git-send-email-jp_ikaheimonen@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1273221413==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey JP!

So here is the deal with this big patch set and the 2.4-rc ;).

I've checked the patches and they are OK in terms of code and structure.
The feature seems to work fine also! Which is a good news. However, we
are a couple hours before the release candidate! and there is still
issues with all this :S.

We know that you guys have been putting a lot of efforts in this and the
code looks good so what we are going to do is merge this in the next RC
release (meaning 2.4-rc2) considering that right now the feature works
and thus is freezed for the next version.

For that to happen, I'll ask you to fix the following issues as soon as
you can so we can merge it quickly thus having more testing. Not getting
this in time, unfortunately we won't be able to merge that for 2.4.
Usually, the RC process cycle is around 1 month maximum.

Issues:

1) "make check" fails here so it *has* to pass in order to accept this
patch set. I didn't investiguate thoroughly but it might be that you
broke some existing feature or small adjustement to the tests.

2) For this kind of big feature, we *need* at least one test that makes
sure that in further release there is no regression for that exclusion
feature.

3) A patch for the man page (lttng.1) would be *very* appreciated.

4) Commit id: 78bef43205f5296cb6cae81b6e264b849fe94988
Please add a PERROR() if the zmalloc returns NULL so we can at least
report it somewhere.

I've fixed small issues also so please look at my dev branch for the two
small commits on top of the 28 patches.

https://github.com/dgoulet/lttng-tools-dev/tree/ev-exclusion

Considering that, either you send back the patches *ON TOP* of that dev
branch or you can also provide me with a pull request because with that
amount of patches, by email is kind of a pain :).

Hope this seems fair enough with you guys. It's the best we can do to
make sure this feature gets in 2.4 :).

Cheers!
David

On 07 Nov (12:16:43), JP Ikaheimonen wrote:
> This patch set, along with a patch set for lttng-ust, implements
> a new option for lttng enable-event command.
>=20
> The new option makes it possible to exclude events from a wildcarded
> event definition.
>=20
> That is, running command
>=20
> lttng enable-event -u -c c1 'myevents*' -x 'myevents:dbg*'
>=20
> would enable all UST tracepoint events whose names start with 'myevents'
> except those that start with 'myevents:dbg'.
>=20
> The lttng list command is also updated, so that it points out the
> fact that an event has some exclusions.
>=20
> JP Ikaheimonen (28):
>   Add exclusion data to enable-command
>   Define a structure for event exclusion data
>   Add exclusion data to cmd_enable_event
>   Add exclusions to event_ust_enable_tracepoint
>   Add event exclusion data to ltt_ust_event structure
>   Add exclusion matching logic to trace_ust_ht_match_event
>   Add exclusion data to trace_ust_create_event
>   Add exclusion data to trace_ust_find_event
>   Copy exclusion data in add_unique_ust_event.
>   Add new error codes for exclusion processing
>   Add handling of LTTNG_ENABLE_EVENT_WITH_EXCLUSION
>   Collate handling of LTTNG_ENABLE_EVENT_WITH_FILTER
>   Add exclusion data to ust_app_event structure
>   Compare also exclusions in ht_match_ust_app_event
>   Copy event exclusion data in add_unique_ust_app_event
>   Free exclusion data when ust_app_event is deleted
>   Add exclusion data to find_ust_app_event
>   Copy exclusion data in shadow_copy_event
>   Set event exclusions in the target when event is created
>   Send enable-event commands with exclusion data
>   Collate lttng_enable_event* code
>   Add -exclude option to enable-event command
>   Add usage for --exclude option
>   Add a function to check for legal exclusions
>   Parse exclusions and forward them to the control handler
>   Detect and report exclusion option errors
>   Add exclusion names to diagnostic printouts
>   When listing events, show exclusions if they exist
>=20
>  include/lttng/lttng-error.h              |   2 +
>  include/lttng/lttng.h                    |  20 ++-
>  src/bin/lttng-sessiond/cmd.c             |  13 +-
>  src/bin/lttng-sessiond/cmd.h             |   4 +-
>  src/bin/lttng-sessiond/event.c           |  12 +-
>  src/bin/lttng-sessiond/event.h           |   3 +-
>  src/bin/lttng-sessiond/main.c            | 110 +++++++-----
>  src/bin/lttng-sessiond/trace-ust.c       |  23 ++-
>  src/bin/lttng-sessiond/trace-ust.h       |  14 +-
>  src/bin/lttng-sessiond/ust-app.c         |  95 +++++++++-
>  src/bin/lttng-sessiond/ust-app.h         |   2 +
>  src/bin/lttng/commands/enable_events.c   | 242 +++++++++++++++++++++++--
>  src/bin/lttng/commands/list.c            |  15 +-
>  src/common/sessiond-comm/sessiond-comm.h |  22 ++-
>  src/lib/lttng-ctl/lttng-ctl.c            | 291 ++++++++++++++++++-------=
------
>  tests/unit/test_ust_data.c               |   2 +-
>  16 files changed, 657 insertions(+), 213 deletions(-)
>=20
> --=20
> 1.8.1.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSg+ouXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02onYH/1aknRZ3ua50hfd9RbyMUy73
B+pDHI/2d8imCKBrmmx4XZH7/H82IaYCWQCSu96JzXz9oaeSP0dSRCLEaZTPztf5
46cLZCX+Iuf2wWIubaZLjTWmcciZQyWYJ8OpKIHglw7xqeTIoqiKCvA7H0BUwsfR
vMEGMVMQJTNRQ+YYSH6T9F4uYk/R3KII4wXRqn35V4LrTLR3yorVhLyi0fNS22r4
nGsowKDIPrPEV86zB/lnmoeQnU2s0FI9quo5O9nnDUsiZyYMsOWBuklVrSdpRn4q
Sf1oIAHq+OPQscvMJf6we33ZZ7KTjGlEVtKsTf7kF2dGvIbFUBhOlQshBR9a7NY=
=uxjO
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--


--===============1273221413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1273221413==--
