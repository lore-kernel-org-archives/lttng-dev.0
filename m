From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Userspace privilege
Date: Mon, 15 Sep 2014 13:23:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5121A290__25419.3657114685$1410787493$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XTWG1-000307-3n
 for lttng-dev@lists.lttng.org; Mon, 15 Sep 2014 09:23:55 -0400
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

----------------------------------------------------------------------
Date: Sat, 13 Sep 2014 05:33:29 +0800
From: Manikandan Govindaswamy <magov@vestas.com>

> We have a busybox version target and starting the lttng on root privilege.
>
> The kernel traces  works fine and we could get all the traces, we have ap=
plication which needs root privilege to start some part of services and als=
o has tracepoints in it, so have to run my application from root ( part of =
tracing group).
>
> When I start the another tracing from an user account who is part of trac=
ing group, if I run the lttng list, it opens a new session for the user?
>
> So could not possible to see the user space tracepoints which I've starte=
d from root( though it's part of tracing group).
>
> If the user also part of tracing group then the session started by root s=
hould have been used by the user trace list, and possible to see the tracep=
oints or not?
>
> GMK.
----------------------------------------------------------------------
   I'm not sure I understand your question correctly, but I'll try to answe=
r it anyway.

   Your setup sounds right: you have lttng-sessiond running as a root servi=
ce, and your tracing users are part of the tracing group.

   Sessions are per-user objects, so one user cannot control another's sess=
ions (unless he impersonates that user using 'sudo -H -u <username> lttng .=
..').

   As long as you are a member of the tracing group, you will see all avail=
able user-space tracepoints, from all user-spaces, even root's.  Two tracin=
g users can create individual sessions, each of which can subscribe to the =
same user-space tracepoints.  There will be discrepancies in the time-stamp=
s of the events in either trace, however (that is to say, the same event wi=
ll register under slightly different timestamps in either user's trace).

   If you want two users to control the same root session (necessary in ord=
er to see root's user-space tracepoints), they need to both impersonate roo=
t.  This is done by systematically issuing 'sudo -H lttng ...' commands.

   For more details, see section 3.4 of the LTTng Comprehensive User's Guid=
e (soon to be available; either I or Christian Babeux can send you an advan=
ce copy if you'd like).

   If the above does not address your concerns, please explain in detail wi=
th sample session extracts.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
