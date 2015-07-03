From: kranthi kumar <kranthi.vskp@gmail.com>
Subject: Lttng 2.6 relayd hanged
Date: Fri, 3 Jul 2015 23:32:12 +0200
Message-ID: <CA+=ghtPz_0VPxXH+nVBbsx_j4GVCd2U+Uxfep40bTCYud1otWw__24113.6994133287$1436185548$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847437274=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <kranthi.vskp@gmail.com>) id 1ZB8ZG-0005Hu-AO
 for lttng-dev@lists.lttng.org; Fri, 03 Jul 2015 17:32:23 -0400
Received: by wiar9 with SMTP id r9so140929679wia.1
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jul 2015 14:32:12 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1847437274==
Content-Type: multipart/alternative; boundary=f46d043c7f1e03cf100519ff4a2e

--f46d043c7f1e03cf100519ff4a2e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Sir/Madam,



  We are using Lttng 2.6

  We are using Lttng for tracing across multiple systems.

  We have a relayd running on a remote-host with several system(4) with 2
active sessions each, generating traces towards this remote-host.

  After running for 2-3 days, we observed that the tracing systems
restarted and the sessions are killed.

  However we observed sockets of relayd in ESTABLISHED state.  We also
verified that ps command showing relayd active. From =E2=80=9Cnetstat =E2=
=80=93tanp=E2=80=9D we
confirmed that relayd is listening on default port.



 When we tried to establish new sessions and start streaming towards this
relayd from our trace generating systems(all 4 one at a time) again, all
the systems hanged indefinitely without showing any error messages.



The only way to recover our trace generating systems is to restart the
relayd on remote host.  If you restart the relayd and then create new
sessions, streaming can be started again.



Please let us know if this is a known issue.





BR



Kranthi.

--f46d043c7f1e03cf100519ff4a2e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">Dear
Sir/Madam,</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0 </span>We are using Lttng 2.6</s=
pan></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0 </span>We are using Lttng for tr=
acing across multiple
systems.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0 </span>We have a relayd running =
on a remote-host
with several system(4) with 2 active sessions each, generating traces towar=
ds
this remote-host.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0 </span>After running for 2-3 day=
s, we observed that
the tracing systems restarted and the sessions are killed.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0 </span>However we observed socke=
ts of relayd in
ESTABLISHED state. <span style=3D"mso-spacerun:yes">=C2=A0</span>We also ve=
rified that
ps command showing relayd active. From =E2=80=9Cnetstat =E2=80=93tanp=E2=80=
=9D we confirmed that relayd
is listening on default port.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S"><span style=3D"mso-spacerun:yes">=C2=A0</span>When we tried to establish=
 new sessions and
start streaming towards this relayd from our trace generating systems(all 4=
 one
at a time) again, all the systems hanged indefinitely without showing any e=
rror
messages.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">The only
way to recover our trace generating systems is to restart the relayd on rem=
ote
host. <span style=3D"mso-spacerun:yes">=C2=A0</span>If you restart the rela=
yd and then
create new sessions, streaming can be started again.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">Please let
us know if this is a known issue.</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">BR</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-US" lang=3D"EN-U=
S">Kranthi. </span></p>

</div>

--f46d043c7f1e03cf100519ff4a2e--


--===============1847437274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1847437274==--
