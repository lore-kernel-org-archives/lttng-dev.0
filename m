From: Yiteng Guo <guoyiteng@gmail.com>
Subject: HugePages shared memory support in LLTng
Date: Fri, 12 Jul 2019 18:18:44 -0400
Message-ID: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw__43915.6792521075$1562969955$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4680703969664932047=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by lists.lttng.org (Postfix) with ESMTPS id 45lnQ96y0wz1Dfv
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2019 18:18:57 -0400 (EDT)
Received: by mail-wr1-x436.google.com with SMTP id r1so11347087wrl.7
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2019 15:18:57 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4680703969664932047==
Content-Type: multipart/alternative; boundary="000000000000d17a47058d834b52"

--000000000000d17a47058d834b52
Content-Type: text/plain; charset="UTF-8"

Hello,

I am wondering if there is any way for lttng-ust to create its shm on
hugepages. I noticed that there was an option `--shm-path` which can be
used to change the location of shm. However, if I specified the path to a
`hugetlbfs` such as /dev/hugepages, I would get errors in lttng-sessiond
and no trace data were generated.

The error I got was
```
PERROR - 17:54:56.740674 [8163/8168]: Error appending to metadata file:
Invalid argument (in lttng_metadata_printf() at ust-metadata.c:176)
Error: Failed to generate session metadata (errno = -1)
```
I took a look at lttng code base and found that lttng used `write` to
generate a metadata file under `--shm-path`. However, it looks like
`hugetlbfs` does not support `write` operation. I did a simple patch with
`mmap` to get around this problem. Then, I got another error:
```
Error: Error creating UST channel "my-channel" on the consumer daemon
```
This time, I could not locate the problem anymore :(. Do you have any idea
of how to get hugepages shm work in lttng?

To give you more context here, I was tracing a performance sensitive
program. I didn't want to suffer from the sub-buffer switch cost so I
created a very large sub-buffer (1MB). I did a benchmark on my tracepoint
and noticed that after running a certain number of tracepoints, I got a
noticeably larger overhead (1200ns larger than other) for every ~130
tracepoints. It turned out that this large overhead was due to a page
fault. The numbers were matched up (130 * 32 bytes = 4160 bytes, which is
approximately the size of a normal page 4kB) and I also used lttng perf
page fault counters to verify it. Therefore, I am looking for a solution to
have lttng create shm on hugepages.

Thank you very much! I look forward to hearing from you.

Best,
Yiteng

--000000000000d17a47058d834b52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am wondering if there is any w=
ay for lttng-ust to create its shm on hugepages. I noticed that there was a=
n option `--shm-path` which can be used to change the location of shm. Howe=
ver, if I specified the path to a `hugetlbfs` such as /dev/hugepages, I wou=
ld get errors in lttng-sessiond and no trace data were generated.</div><div=
><br></div><div>The error I got was=C2=A0</div><div>```</div><div>PERROR - =
17:54:56.740674 [8163/8168]: Error appending to metadata file: Invalid argu=
ment (in lttng_metadata_printf() at ust-metadata.c:176)<br>Error: Failed to=
 generate session metadata (errno =3D -1)<br></div><div>```</div><div>I too=
k a look at lttng code base and found that lttng used `write` to generate a=
 metadata file under `--shm-path`. However, it looks like `hugetlbfs` does =
not support `write` operation. I did a simple patch with `mmap` to get arou=
nd this problem. Then, I got another error:</div><div>```</div><div>Error: =
Error creating UST channel &quot;my-channel&quot; on the consumer daemon<br=
></div><div>```</div><div>This time, I could not locate the problem anymore=
 :(. Do you have any idea of how to get hugepages shm work in lttng?</div><=
div><br></div><div>To give you more context here, I was tracing a performan=
ce sensitive program. I didn&#39;t want to suffer from the sub-buffer switc=
h cost so I created a very large sub-buffer (1MB). I did a benchmark on my =
tracepoint and noticed that after running a certain number of tracepoints, =
I got a noticeably larger overhead (1200ns larger than other) for every ~13=
0 tracepoints.=C2=A0It turned out that this large overhead was due to a pag=
e fault. The numbers were matched up (130 * 32 bytes =3D 4160 bytes, which =
is approximately the size of a normal page 4kB) and I also used lttng perf =
page fault counters to verify it. Therefore, I am looking for a solution to=
 have lttng create shm on hugepages.</div><div><br></div><div>Thank you ver=
y much! I look forward to hearing from you.</div><div><br></div><div>Best,<=
/div><div>Yiteng</div></div>

--000000000000d17a47058d834b52--

--===============4680703969664932047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4680703969664932047==--
