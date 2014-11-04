From: Bin YE <yebinianhi@gmail.com>
Subject: babeltrace-python bindings
Date: Tue, 4 Nov 2014 14:37:12 -0800
Message-ID: <CAETqSHAgdD8_9XZZvc_LTmD_pUHSV=i05h4sqww7gDFf+WGU+w__3573.7308361151$1415146573$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0834923634=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yebinianhi@gmail.com>) id 1Xlmj0-0000uT-EU
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 17:37:20 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so3425068lbi.8
 for <lttng-dev@lists.lttng.org>; Tue, 04 Nov 2014 14:37:12 -0800 (PST)
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

--===============0834923634==
Content-Type: multipart/alternative; boundary=001a11c33e96ae8fe50507101a33

--001a11c33e96ae8fe50507101a33
Content-Type: text/plain; charset=UTF-8

Hi there

i have installed Lttng and babeltrace
my system:Ubuntu 14.04LTS
I have made following steps

sudo apt-add-repository ppa:lttng/ppa
sudo apt-get update
sudo apt-get install lttng-tools
sudo apt-get install lttng-modules-dkms
sudo apt-get install liblttng-ust-dev

export PYTHON="python3"
export PYTHON_CONFIG="/usr/bin/python3-config"

./configure --enable-python-bindings
 make
 make install
 ldconfig

but i still can not use babeltrace python bindings
when i run import babeltrace it output error with no module

I really need you help about it
Thank you very much in advance

Bin Ye

--001a11c33e96ae8fe50507101a33
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi there<br><br></div>i=
 have installed Lttng and babeltrace<br></div>my system:Ubuntu 14.04LTS<br>=
I have made following steps<br><br><pre class=3D"">sudo apt-add-repository =
ppa:lttng/ppa
sudo apt-get update
sudo apt-get install lttng-tools
sudo apt-get install lttng-modules-dkms
sudo apt-get install liblttng-ust-dev</pre>export PYTHON=3D&quot;python3&qu=
ot;<br>export PYTHON_CONFIG=3D&quot;/usr/bin/python3-config&quot;<br><br>./=
configure --enable-python-bindings<br>=C2=A0make<br>=C2=A0make install<br>=
=C2=A0ldconfig<br><br></div>but i still can not use babeltrace python bindi=
ngs<br></div>when i run import babeltrace it output error with no module<br=
><br></div>I really need you help about it <br></div>Thank you very much in=
 advance<br><br></div>Bin Ye<br></div>

--001a11c33e96ae8fe50507101a33--


--===============0834923634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0834923634==--
