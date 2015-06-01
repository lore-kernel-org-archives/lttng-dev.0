From: Jessica Foest <jessica.foest@gmail.com>
Subject: lttng kernel events
Date: Mon, 1 Jun 2015 11:15:54 -0400
Message-ID: <CAPxN80CcSme-h=OJ3L33+1FAW-X8qCYFF7Trpy=LSX2D6QouOA__22830.7564430454$1433171839$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0224350494=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0224350494==
Content-Type: multipart/alternative; boundary=047d7b5d33da58ee600517764d92

--047d7b5d33da58ee600517764d92
Content-Type: text/plain; charset=UTF-8

Hi all,

Normally the following perf software event means the same thing :

page-faults OR faults
context-switches OR cs
cpu-migrations OR migrations

The questions is why both of them (the two representation of the event) are
presented in the context options of LTTng?

When i try to activate them when tracing the kernel activities no error
displayed, it means that both of them works fine.

is that normal ?

Regards

--047d7b5d33da58ee600517764d92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>Normally the following perf sof=
tware event means the same thing :<br></div><div><div><br></div><div>page-f=
aults OR faults</div><div>context-switches OR cs=C2=A0</div><div>cpu-migrat=
ions OR migrations=C2=A0</div></div><div><br></div><div>The questions is wh=
y both of them (the two representation of the event) are presented in the c=
ontext options of LTTng?</div><div><br></div><div>When i try to activate th=
em when tracing the kernel activities no error displayed, it means that bot=
h of them works fine.</div><div><br></div><div>is that normal ?</div><div><=
br></div><div>Regards<br></div><div>=C2=A0<br></div></div>

--047d7b5d33da58ee600517764d92--


--===============0224350494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0224350494==--
