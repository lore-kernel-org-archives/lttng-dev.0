From: Ashoka K <ashok.vinu@gmail.com>
Subject: Need help to install LTTng on Ubunto 10.04
Date: Tue, 4 Sep 2012 12:48:09 +0530
Message-ID: <CALJd4cYWZM3DjFRpe2QB4sxpcWzxpSQ_=zRK=RUtCWBgEnKH0w__24250.3589754508$1346743580$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0620337515=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ashok.vinu@gmail.com>) id 1T8nOp-0004r7-Go
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 03:18:16 -0400
Received: by wgx1 with SMTP id 1so3957480wgx.23
	for <lttng-dev@lists.lttng.org>; Tue, 04 Sep 2012 00:18:09 -0700 (PDT)
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

--===============0620337515==
Content-Type: multipart/alternative; boundary=0016367b61f870d28a04c8db0f91

--0016367b61f870d28a04c8db0f91
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have tried the below commands to install LTT on  VMware running Ubuntu
10.04, but got the following error. Please help.

From link : https://launchpad.net/~lttng/+archive/ppa

$ sudo apt-add-repository ppa:lttng/ppa
$ sudo apt-get update
$ sudo apt-get install lttng-tools lttng-modules-dkms babeltrace


user@usr:~$ sudo apt-add-repository ppa:lttng/ppa
Executing: gpg --ignore-time-conflict --no-options --no-default-keyring
--secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trustdb.gpg
--keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg
--keyserver keyserver.ubuntu.com --recv
C541B13BD43FA44A287E4161F4A7DFFC33739778
gpg: requesting key 33739778 from hkp server keyserver.ubuntu.com
gpg: unable to execute program `/usr/local/libexec/gnupg/gpgkeys_curl': No
such file or directory
gpg: no handler for keyserver scheme `hkp'
gpg: keyserver receive failed: keyserver error
user@usr:~$

user@usr:~$ sudo apt-get update
.....
$

user@usr:~$ sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
Reading package lists... Done
Building dependency tree
Reading state information... Done
E: Couldn't find package lttng-tools
user@usr:~$


My systemm details:


user@usr:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=10.04
DISTRIB_CODENAME=lucid
DISTRIB_DESCRIPTION="Ubuntu 10.04.4 LTS"
user@usr:~$
user@usr:~$
user@usr:~$ uname -a
Linux usr 2.6.32-42-generic #95-Ubuntu SMP Wed Jul 25 15:57:54 UTC 2012
i686 GNU/Linux
user@usr:~$



Regards
Ashoka.  K

--0016367b61f870d28a04c8db0f91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font><font face=3D"verdana,sans-serif">Hi,</font></font><=
div><font><font face=3D"verdana,sans-serif"><br></font></font></div><div><f=
ont><font face=3D"verdana,sans-serif">I have tried the below commands to in=
stall LTT on =A0VMware running Ubuntu 10.04, but got the following error. P=
lease help.</font></font></div>
<div><font><font face=3D"verdana,sans-serif"><br></font></font></div><div><=
font><font face=3D"verdana,sans-serif">From link :=A0</font></font><a href=
=3D"https://launchpad.net/~lttng/+archive/ppa">https://launchpad.net/~lttng=
/+archive/ppa</a></div>
<div><br></div><div><span style=3D"color:rgb(51,51,51);font-family:&#39;Ubu=
ntu Mono&#39;,monospace;font-size:12px;line-height:18px;background-color:rg=
b(255,255,255)">$ sudo apt-add-repository ppa:lttng/ppa</span><br style=3D"=
color:rgb(51,51,51);font-family:&#39;Ubuntu Mono&#39;,monospace;font-size:1=
2px;line-height:18px;background-color:rgb(255,255,255)">
<span style=3D"color:rgb(51,51,51);font-family:&#39;Ubuntu Mono&#39;,monosp=
ace;font-size:12px;line-height:18px;background-color:rgb(255,255,255)">$ su=
do apt-get update</span><br style=3D"color:rgb(51,51,51);font-family:&#39;U=
buntu Mono&#39;,monospace;font-size:12px;line-height:18px;background-color:=
rgb(255,255,255)">
<span style=3D"color:rgb(51,51,51);font-family:&#39;Ubuntu Mono&#39;,monosp=
ace;font-size:12px;line-height:18px;background-color:rgb(255,255,255)">$ su=
do apt-get install lttng-tools lttng-modules-dkms babeltrace</span>
</div><div><font><font face=3D"verdana,sans-serif"><br></font></font></div>=
<div><font><font face=3D"verdana,sans-serif"><br></font></font></div><div><=
font><font face=3D"verdana,sans-serif"><div>user@usr:~$ sudo apt-add-reposi=
tory ppa:lttng/ppa</div>
<div>Executing: gpg --ignore-time-conflict --no-options --no-default-keyrin=
g --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trustdb.gpg=
 --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --ke=
yserver <a href=3D"http://keyserver.ubuntu.com">keyserver.ubuntu.com</a> --=
recv C541B13BD43FA44A287E4161F4A7DFFC33739778</div>
<div>gpg: requesting key 33739778 from hkp server <a href=3D"http://keyserv=
er.ubuntu.com">keyserver.ubuntu.com</a></div><div>gpg: unable to execute pr=
ogram `/usr/local/libexec/gnupg/gpgkeys_curl&#39;: No such file or director=
y</div>
<div>gpg: no handler for keyserver scheme `hkp&#39;</div><div>gpg: keyserve=
r receive failed: keyserver error</div><div>user@usr:~$=A0</div><div><br></=
div><div>user@usr:~$ sudo apt-get update</div><div>.....</div><div>$</div>
<div><br></div><div><div>user@usr:~$ sudo apt-get install lttng-tools lttng=
-modules-dkms babeltrace</div><div>Reading package lists... Done</div><div>=
Building dependency tree =A0 =A0 =A0=A0</div><div>Reading state information=
... Done</div>
<div>E: Couldn&#39;t find package lttng-tools</div><div>user@usr:~$=A0</div=
></div><div><br></div></font></font></div><div><br></div><div>My systemm de=
tails:</div><div><br></div><div><br></div><div><div>user@usr:~$ cat /etc/ls=
b-release=A0</div>
<div>DISTRIB_ID=3DUbuntu</div><div>DISTRIB_RELEASE=3D10.04</div><div>DISTRI=
B_CODENAME=3Dlucid</div><div>DISTRIB_DESCRIPTION=3D&quot;Ubuntu 10.04.4 LTS=
&quot;</div><div>user@usr:~$=A0</div><div>user@usr:~$=A0</div><div>user@usr=
:~$ uname -a</div>
<div>Linux usr 2.6.32-42-generic #95-Ubuntu SMP Wed Jul 25 15:57:54 UTC 201=
2 i686 GNU/Linux</div><div>user@usr:~$=A0</div></div><div><br></div><div><b=
r></div><div><br></div><div><div>Regards</div><div>Ashoka. =A0K</div><br>
</div></div>

--0016367b61f870d28a04c8db0f91--


--===============0620337515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0620337515==--
