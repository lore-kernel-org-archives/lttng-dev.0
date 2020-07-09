From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Payload of syscall_entry_execve
Date: Thu, 9 Jul 2020 14:19:25 +0300
Message-ID: <CABhb4uu6dxo_5pVUTXaz3qkGS41Ame77Bp5ePWT42cJ2PANFvA@mail.gmail.com>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0238892498087045081=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4B2Ybz0Xr9z1CPR
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2020 07:19:42 -0400 (EDT)
Received: by mail-oi1-x229.google.com with SMTP id t198so1569698oie.7
 for <lttng-dev@lists.lttng.org>; Thu, 09 Jul 2020 04:19:42 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0238892498087045081==
Content-Type: multipart/alternative; boundary="0000000000009f003405aa0066a8"

--0000000000009f003405aa0066a8
Content-Type: text/plain; charset="UTF-8"

Hello!

Currently, I'm developing a process monitor on the base of LTTng, and I
face the challenge of accessing command-line arguments passed to execve
syscall.
I'm using LTTng live session and Babeltrace 2 C API to analyze events in
online mode.

syscall_entry_execve event has 3 payload fields: filename, argv, and envp.
The first one is a normal C-string, the second and the third
semantically are `char *const *`,
but provided by LTTng as simple unsigned integers (the corresponding fields
in Babaltrace2 event payload have type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,
while I expect BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand,
these integers are argv and envp pointers casted to uint64_t. But in the
majority of
cases, events produced by LTTng are analyzed by another process and often
even offline, so these pointers became completely unuseful.

Could you say, if there are some configuration parameters that enable to
pass argv and envp content in syscall_entry_execve payload? Or some other
ways to get this
information from LTTng.

P.S. I consider getting this information from /proc/pid/cmdline, but it is
not looking like a clean solution.

Best regards.
Valentin Grigorev

--0000000000009f003405aa0066a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hello!</div><div><br></div=
><div>Currently, I&#39;m developing a process monitor on the base of LTTng,=
 and I face the challenge of accessing command-line arguments passed to exe=
cve syscall.=C2=A0</div><div>I&#39;m using LTTng live session and Babeltrac=
e 2 C API to analyze events in online mode.</div><div><br></div><div>syscal=
l_entry_execve=C2=A0event has 3 payload fields: filename, argv, and envp. T=
he first one is a normal C-string, the second and the third semantically=C2=
=A0are `char *const *`,=C2=A0</div><div>but provided by LTTng as simple uns=
igned integers (the corresponding fields in Babaltrace2 event payload have =
type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,</div><div>while I expect BT_FIEL=
D_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand, these integers are arg=
v and envp pointers casted to uint64_t. But in the majority of</div><div>ca=
ses, events produced by LTTng are analyzed by another process and often eve=
n offline, so these pointers became completely unuseful.</div><div><br></di=
v><div>Could you say, if there are some configuration parameters=C2=A0that =
enable to pass argv and envp content in syscall_entry_execve payload? Or so=
me other ways to get this</div><div>information from LTTng.</div><div><br><=
/div><div>P.S. I consider getting this information from /proc/pid/cmdline, =
but it is not looking like a clean solution.</div><div><br></div><div>Best =
regards.</div><div>Valentin Grigorev<br></div></div></div></div></div></div=
></div></div>

--0000000000009f003405aa0066a8--

--===============0238892498087045081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0238892498087045081==--
