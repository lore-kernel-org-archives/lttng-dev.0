From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: session.id unsigned int vs. uint64_t
Date: Thu, 4 Jul 2013 19:06:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD13422902__15099.4299947799$1372964856$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Uuorl-0004WG-3a
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 15:06:53 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

~~~~~~src/bin/lttng-sessiond/session.h:60:

struct ltt_session {
...
        unsigned int id;

~~~~~~src/bin/lttng-sessiond/trace-ust.c:185:

struct ltt_ust_session *trace_ust_create_session(uint64_t session_id)

~~~~~~src/bin/lttng-sessiond/main.c:2352:

static int create_ust_session(struct ltt_session *session,
               struct lttng_domain *domain)
{
...
        lus =3D trace_ust_create_session(session->id);

~~~~~~src/bin/lttng-sessiond/trace-ust.h:

#ifdef HAVE_LIBLTTNG_UST_CTL
...
struct ltt_ust_session *trace_ust_create_session(uint64_t session_id);
...
#else /* HAVE_LIBLTTNG_UST_CTL */
...
static inline
struct ltt_ust_session *trace_ust_create_session(unsigned int session_id)


   32-bit-wide unsigned ints and 64-bit-wide uint64_ts are not truly interc=
hangeable.  The ltt_session.id should be widened to uint64_t.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
