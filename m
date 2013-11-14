From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 00/28] UST Event exclusions
Date: Thu, 14 Nov 2013 15:52:39 -0500
Message-ID: <20131114205239.GD22503__36873.3407966376$1384462429$gmane$org@thessa>
References: <1383819403-6386-1-git-send-email-jp_ikaheimonen@mentor.com>
	<20131113210758.GB7694@dalia>
	<009B25148989C6458484484699278506E539FA93@EU-MBX-01.mgc.mentorg.com>
	<009B25148989C6458484484699278506E539FBEE@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0253092956=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vh3uB-0000IS-Pr
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 15:52:54 -0500
In-Reply-To: <009B25148989C6458484484699278506E539FBEE@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0253092956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's now upstream!

Thanks!
David

On 14 Nov (14:42:28), Ikaheimonen, JP wrote:
> Hi again David,
> I've got a new commit set set up in=20
> https://github.com/jpikahei/lttng-tools
> branch jpikahei_event_exclusion
>=20
> Please pull the changes from there.
> I've fixed the small issues you mentioned, plus added a test and updated =
the man page.
>=20
> Cheers,
> JP
>=20
> -----Original Message-----
> From: Ikaheimonen, JP=20
> Sent: 14. marraskuuta 2013 9:29
> To: David Goulet
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH lttng-tools 00/28] UST Event exclusions
>=20
> Thanks David!
> I'll add your changes, figure out what goes wrong with the test, add a ne=
w test, and patch the man page.
> Then I will submit a pull request.
> I aim to have done this by the end of this week.
>=20
> Thanks again,
> JP
>=20
> -----Original Message-----
> From: David Goulet [mailto:dgoulet@efficios.com]
> Sent: 13. marraskuuta 2013 23:08
> To: Ikaheimonen, JP
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH lttng-tools 00/28] UST Event exclusions
>=20
> Hey JP!
>=20
> So here is the deal with this big patch set and the 2.4-rc ;).
>=20
> I've checked the patches and they are OK in terms of code and structure.
> The feature seems to work fine also! Which is a good news. However, we ar=
e a couple hours before the release candidate! and there is still issues wi=
th all this :S.
>=20
> We know that you guys have been putting a lot of efforts in this and the =
code looks good so what we are going to do is merge this in the next RC rel=
ease (meaning 2.4-rc2) considering that right now the feature works and thu=
s is freezed for the next version.
>=20
> For that to happen, I'll ask you to fix the following issues as soon as y=
ou can so we can merge it quickly thus having more testing. Not getting thi=
s in time, unfortunately we won't be able to merge that for 2.4.
> Usually, the RC process cycle is around 1 month maximum.
>=20
> Issues:
>=20
> 1) "make check" fails here so it *has* to pass in order to accept this pa=
tch set. I didn't investiguate thoroughly but it might be that you broke so=
me existing feature or small adjustement to the tests.
>=20
> 2) For this kind of big feature, we *need* at least one test that makes s=
ure that in further release there is no regression for that exclusion featu=
re.
>=20
> 3) A patch for the man page (lttng.1) would be *very* appreciated.
>=20
> 4) Commit id: 78bef43205f5296cb6cae81b6e264b849fe94988
> Please add a PERROR() if the zmalloc returns NULL so we can at least repo=
rt it somewhere.
>=20
> I've fixed small issues also so please look at my dev branch for the two =
small commits on top of the 28 patches.
>=20
> https://github.com/dgoulet/lttng-tools-dev/tree/ev-exclusion
>=20
> Considering that, either you send back the patches *ON TOP* of that dev b=
ranch or you can also provide me with a pull request because with that amou=
nt of patches, by email is kind of a pain :).
>=20
> Hope this seems fair enough with you guys. It's the best we can do to mak=
e sure this feature gets in 2.4 :).
>=20
> Cheers!
> David
>=20
> On 07 Nov (12:16:43), JP Ikaheimonen wrote:
> > This patch set, along with a patch set for lttng-ust, implements a new=
=20
> > option for lttng enable-event command.
> >=20
> > The new option makes it possible to exclude events from a wildcarded=20
> > event definition.
> >=20
> > That is, running command
> >=20
> > lttng enable-event -u -c c1 'myevents*' -x 'myevents:dbg*'
> >=20
> > would enable all UST tracepoint events whose names start with 'myevents'
> > except those that start with 'myevents:dbg'.
> >=20
> > The lttng list command is also updated, so that it points out the fact=
=20
> > that an event has some exclusions.
> >=20
> > JP Ikaheimonen (28):
> >   Add exclusion data to enable-command
> >   Define a structure for event exclusion data
> >   Add exclusion data to cmd_enable_event
> >   Add exclusions to event_ust_enable_tracepoint
> >   Add event exclusion data to ltt_ust_event structure
> >   Add exclusion matching logic to trace_ust_ht_match_event
> >   Add exclusion data to trace_ust_create_event
> >   Add exclusion data to trace_ust_find_event
> >   Copy exclusion data in add_unique_ust_event.
> >   Add new error codes for exclusion processing
> >   Add handling of LTTNG_ENABLE_EVENT_WITH_EXCLUSION
> >   Collate handling of LTTNG_ENABLE_EVENT_WITH_FILTER
> >   Add exclusion data to ust_app_event structure
> >   Compare also exclusions in ht_match_ust_app_event
> >   Copy event exclusion data in add_unique_ust_app_event
> >   Free exclusion data when ust_app_event is deleted
> >   Add exclusion data to find_ust_app_event
> >   Copy exclusion data in shadow_copy_event
> >   Set event exclusions in the target when event is created
> >   Send enable-event commands with exclusion data
> >   Collate lttng_enable_event* code
> >   Add -exclude option to enable-event command
> >   Add usage for --exclude option
> >   Add a function to check for legal exclusions
> >   Parse exclusions and forward them to the control handler
> >   Detect and report exclusion option errors
> >   Add exclusion names to diagnostic printouts
> >   When listing events, show exclusions if they exist
> >=20
> >  include/lttng/lttng-error.h              |   2 +
> >  include/lttng/lttng.h                    |  20 ++-
> >  src/bin/lttng-sessiond/cmd.c             |  13 +-
> >  src/bin/lttng-sessiond/cmd.h             |   4 +-
> >  src/bin/lttng-sessiond/event.c           |  12 +-
> >  src/bin/lttng-sessiond/event.h           |   3 +-
> >  src/bin/lttng-sessiond/main.c            | 110 +++++++-----
> >  src/bin/lttng-sessiond/trace-ust.c       |  23 ++-
> >  src/bin/lttng-sessiond/trace-ust.h       |  14 +-
> >  src/bin/lttng-sessiond/ust-app.c         |  95 +++++++++-
> >  src/bin/lttng-sessiond/ust-app.h         |   2 +
> >  src/bin/lttng/commands/enable_events.c   | 242 +++++++++++++++++++++++=
--
> >  src/bin/lttng/commands/list.c            |  15 +-
> >  src/common/sessiond-comm/sessiond-comm.h |  22 ++-
> >  src/lib/lttng-ctl/lttng-ctl.c            | 291 ++++++++++++++++++-----=
--------
> >  tests/unit/test_ust_data.c               |   2 +-
> >  16 files changed, 657 insertions(+), 213 deletions(-)
> >=20
> > --
> > 1.8.1.2
> >=20
> >=20
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJShTgXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02MaUH/3IM8dHsP5pqQ3wfsCh4QIPt
+d896gFC5zfjv8cz6ljIIA9KIo98QKUE1Qn5gT1zaTnRunmst1sGqy8WU8nyjO6T
WzJUHjpbCC9ZU2zB0zEUOKW6rrWConuWRkw5QSR557QOG3PvIP6zvyUo2sPFWev8
BWui+0lBkiHsNX1j4lnRLE8aHavVnc4E0ExRCv93TotFD6s0h90MDfccMRU2EjIv
PINbGqWr1duLSmV4EmMY9N/0FgNMCP4bEsuHkI7wDBugpRngh52W75py/ZyLLLVh
SKGzlXS13NA7Ntbbx/dcDYJZ5GagEx/tRjVrIQRIbdRri8Uashnrg+2WtMnHrcI=
=OybO
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--


--===============0253092956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0253092956==--
