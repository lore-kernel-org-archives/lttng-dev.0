From: Jonnavithula Sharma <sarmajprs@gmail.com>
Subject: List to insmod lttng modules
Date: Thu, 25 Jul 2013 16:00:53 +0530
Message-ID: <CAJD=Q56sC911-aY5jQpVDZ4Q-6JoxitEQQDvmp_N5TWfGbtyQg__34708.8872608312$1374756661$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1849372073=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f180.google.com ([74.125.82.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sarmajprs@gmail.com>) id 1V2Ip2-0005Hq-3f
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 06:31:04 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so287530wes.11
	for <lttng-dev@lists.lttng.org>; Thu, 25 Jul 2013 03:30:54 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1849372073==
Content-Type: multipart/alternative; boundary=089e0103ecec54a1ea04e25385ee

--089e0103ecec54a1ea04e25385ee
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using lttng-modules 2.2.1 for the kernel 3.8.13 version and i am
successful in compiling it and i see there are lot of ".ko" generated in
probes directory and top level lttng-modules directory.

So now which module needs to insmod first?Can you provide me the list to
which module needs to insmod first .

I tried to insmod some of the .ko i am getting below error.Am i missing
something here?

root@ltqcpe:/ramdisk/tmp# insmod lttng-ring-buffer-client-discard.ko
[94511.780000] lttng_ring_buffer_client_discard: Unknown symbol
lttng_transport_unregister (err 0)
[94511.790000] lttng_ring_buffer_client_discard: Unknown symbol
lttng_transport_register (err 0)
insmod: can't insert 'lttng-ring-buffer-client-discard.ko': unknown symbol
in module, or unknown parameter


Your response is highly aprreciated.


Thanks & Regards,
Sarma J

--089e0103ecec54a1ea04e25385ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I am using lttng-modules 2.2.1 =
for the kernel 3.8.13 version and i am successful in compiling it and i see=
 there are lot of &quot;.ko&quot; generated in probes directory and top lev=
el lttng-modules directory.<br>
<br></div><div>So now which module needs to insmod first?Can you provide me=
 the list to which module needs to insmod first .<br><br></div><div>I tried=
 to insmod some of the .ko i am getting below error.Am i missing something =
here?<br>
<br>root@ltqcpe:/ramdisk/tmp# insmod lttng-ring-buffer-client-discard.ko<br=
>[94511.780000] lttng_ring_buffer_client_discard: Unknown symbol lttng_tran=
sport_unregister (err 0)<br>[94511.790000] lttng_ring_buffer_client_discard=
: Unknown symbol lttng_transport_register (err 0)<br>
insmod: can&#39;t insert &#39;lttng-ring-buffer-client-discard.ko&#39;: unk=
nown symbol in module, or unknown parameter<br><br><br></div><div>Your resp=
onse is highly aprreciated.<br></div><div><br><br></div><div>Thanks &amp; R=
egards,<br>
Sarma J<br></div><div><br></div></div>

--089e0103ecec54a1ea04e25385ee--


--===============1849372073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1849372073==--
