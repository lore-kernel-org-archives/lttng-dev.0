From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: RFC LTTng session and daemon configuration save and
 restore
Date: Thu, 5 Dec 2013 18:45:10 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2BDC__25118.3681343266$1386269163$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VodvE-0001U0-FU
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 13:45:14 -0500
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
List-Id: lttng-dev@lists.lttng.org

> Date: Wed, 4 Dec 2013 16:33:09 -0500
>
> Version:
> - v0.2: 04/12/2013
> [...]
> Daemon configuration files are, by default, either stored system-wide und=
er /etc/lttng/*.conf or in the user's home directory under $HOME/.lttng/*.c=
onf.

   Transient files  (lttng-sessiond.pid, etc., but not .lttngrc) are curren=
tly created under $HOME/.lttng/ (match) and /run/lttng/ (mismatch).  But I =
guess the difference between /run and /etc makes sense in this case.

> Load sessions. If url the is a directory, all .lttng files it contains wi=
ll be loaded. If session_name is NULL, all sessions found in url are restor=
ed.

=AB If url the is a directory =BB?

> int lttng_save_sessions(const char *url, const char *session_name int fla=
gs/struct lttng_session_save_attr *attr);

   Missing commas.

> If a session was saved as active, the tracing for that session will be ac=
tivated automatically on load. [...]
> Tracing sessions saved in an active state will be resumed on load.

   But what if the trace files have gone missing in the mean time?  I think=
 newly-loaded sessions should create new trace folders altogether (let the =
user decide how to merge the trace folders later).  This would be a good oc=
casion to resolve the recurring problem of trace folder collisions (e.g. wh=
en a user-space app being traced per-processID dlcloses and dlopens its tra=
ce provider within a one-second window).  A simple solution is to use the s=
napshot approach, and have a "-%d" sequential sub-index added to the trace =
folder name to avoid the collision.
   Or is the intent to have the conf files store only the "name" part of th=
e sessions, without the timestamp part?  This prevents collisions only when=
 the session is not configured with an output or set-url option.

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
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
