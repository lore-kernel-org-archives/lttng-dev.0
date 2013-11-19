From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Having Trouble with LTTng folders
Date: Tue, 19 Nov 2013 16:48:35 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A2B39__1047.69225367836$1384879781$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VioTc-0005bf-Mj
	for lttng-dev@lists.lttng.org; Tue, 19 Nov 2013 11:48:42 -0500
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
Cc: Michael Steppe <msteppe91@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Date: Tue, 19 Nov 2013 08:43:17 -0500
From: Michael Steppe <msteppe91@gmail.com>

> I have set up another VM that only has a root account. Using Active Direc=
tory, I set up user accounts from my work's development network (giving eve=
ryone here at work the ability to sign in with their usernames and password=
s), meaning root does not have permissions to edit files owned by these use=
rs. Here lies my problem:
>
> Let's say I sign in to the remote VM as user =3D "Scott". When I try and =
attempt to perform the "create" command through my plugin, I get:
>
> An error was encountered on 10.176.15.180 (10.176.15.180)
> Host: 10.176.15.180
> Command: /usr/bin/lttng create TRACE_111913_082211 -o /tmp/TRACE_111913_0=
82211
> Exit Code: 1
> No output stream captured
> Error Output:
>    Error: Unable to create config file
>    Error: Command error
>
> I am assuming it is unable to create the config file because all the trac=
ing folders and files are created and owned by root and root does not have =
access to write to Scott's home directory, where the config file should go.=
 The trace is actually created, but not .lttngrc file is created.
> If I perform an 'lttng list" in the remote VM (signed in as Scott), I can=
 see the TRACE_<date>_<time> and that its status is [inactive] (because we =
haven't started the trace yet).
>
> My question is this. Is there a way, in this version of LTT, to have the =
.lttng and .lttngrc folder/file to be located somewhere else? That way, all=
 the tracing is done by root and the trace files are stored in /tmp and whe=
n the tracing is finished, root can give Scott ownership of the trace files?

   I think you need to change your $HOME when issuing the lttng command.  I=
f 'Scott' has sudo privileges, you could prefix your lttng commands with 's=
udo -H ' and that would do the trick.  Otherwise, just prefix the lttng com=
mand with 'HOME=3D/root '.  This must be done with all lttng commands, beca=
use the client looks .lttngrc up every time (unless you use the --session o=
ption common to nearly all commands).

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
