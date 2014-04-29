From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Problem in userspace-rcu cds_hlist_del_rcu.c caused by
 #define cds_hlist_for_each_entry_safe_2
Date: Tue, 29 Apr 2014 18:59:36 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599E294__41305.802044417$1398798057$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WfDFm-00066v-Er
 for lttng-dev@lists.lttng.org; Tue, 29 Apr 2014 14:59:48 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   When compiling userspace-rcu (commit 81dd913), I get a pair of warnings =
for /userspace-rcu/doc/examples/hlist/cds_hlist_del_rcu.c at the cds_hlist_=
for_each_entry_safe_2 call:

	cds_hlist_for_each_entry_safe_2(node, n, &mylist, node) {
		if (node->value > 0) {
			cds_hlist_del_rcu(&node->node);
			/*
			 * We can only reclaim memory after a grace
			 * period has passed after cds_hlist_del_rcu().
			 */
			call_rcu(&node->rcu_head, free_node_rcu);
		}
	}

   The warnings are:
"attention: assignment makes pointer from integer without a cast"
"attention: left operand of comma operator has no effect"

   The #define comes from userspace-rcu/urcu/hlist.h (here re-arranged a bi=
t):

#define cds_hlist_for_each_entry_safe_2(entry, e, head, member) \
	for (entry =3D ((head)->next =3D=3D NULL ? NULL : cds_hlist_entry((head)->=
next, __typeof__(*entry), member)); \
	        (entry !=3D NULL) && \
	        (e =3D (entry->member.next =3D=3D NULL ? NULL : cds_hlist_entry(en=
try->member.next, __typeof__(*entry), member), 1)); \
	        entry =3D e)

   The cds_hlist_del_rcu.c occurrence is the only use of cds_hlist_for_each=
_entry_safe_2 and the problem seems to me to lie in this bit:

(e =3D (entry->member.next =3D=3D NULL ? NULL : cds_hlist_entry(entry->memb=
er.next, __typeof__(*entry), member), 1))

   Because the comma operator has the lowest precedence of all operators, t=
he statement is equivalent to:

(e =3D ((entry->member.next =3D=3D NULL ? NULL : cds_hlist_entry(entry->mem=
ber.next, __typeof__(*entry), member)), 1)) =


   Which is in turn the same as:

(e =3D 1)

   Now, if the macro is using the comma to make the second part of the && t=
est succeed regardless of the value fetched for e, then it should have been=
 written:

#define cds_hlist_for_each_entry_safe_2(entry, e, head, member) \
	for (entry =3D ((head)->next =3D=3D NULL ? NULL : cds_hlist_entry((head)->=
next, __typeof__(*entry), member)); \
	        (entry !=3D NULL) && \
	        ((e =3D (entry->member.next =3D=3D NULL ? NULL : cds_hlist_entry(e=
ntry->member.next, __typeof__(*entry), member))), 1); \
	        entry =3D e)

   Which does compile without the warnings.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
