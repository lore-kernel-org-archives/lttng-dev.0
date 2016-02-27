From: masoud hematpour <mashemat@gmail.com>
Subject: RCU Reclamation
Date: Sat, 27 Feb 2016 14:24:58 +0100
Message-ID: <CABTiFJbiuKp05X7QYpyVmh74ro6EJYWyOCOc2kfEHxpKCbedUA__2021.95042879811$1456579593$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1452902669=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mashemat@gmail.com>) id 1aZesQ-0004fm-Sn
 for lttng-dev@lists.lttng.org; Sat, 27 Feb 2016 08:25:43 -0500
Received: by mail-yw0-f171.google.com with SMTP id e63so89238550ywc.3
 for <lttng-dev@lists.lttng.org>; Sat, 27 Feb 2016 05:25:42 -0800 (PST)
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

--===============1452902669==
Content-Type: multipart/alternative; boundary=001a1142865ee978f5052cc05981

--001a1142865ee978f5052cc05981
Content-Type: text/plain; charset=UTF-8

Hello to all,

Can you please help me? I confused in the following situation:

     CPU0                                   CPU1
   -----------                              -----------
  rcu_read_lock()                         .
         C.S1                                   .
  rcu_read_unlock()                     .
            .
            .
 rcu_read_lock()
                                                   Update (C.S1)
         C.S2                                  Synchronise_rcu()
                                                   free(men_C.S1)
  rcu_read_unlock()

 synchronize_rcu() wait till end of C.S2?

Thank you very much

--001a1142865ee978f5052cc05981
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hello to all,</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif">Can you please hel=
p me? I confused in the following situation:</div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=C2=A0 =
=C2=A0 =C2=A0CPU0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU1</div><d=
iv class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"=
>=C2=A0 =C2=A0----------- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------</div><di=
v class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=
=C2=A0 rcu_read_lock() =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0C.S1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .</div><div class=3D"g=
mail_default" style=3D"font-family:arial,helvetica,sans-serif">=C2=A0 rcu_r=
ead_unlock() =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .</div><div class=3D"gmail_default" style=3D"font-family:arial,helv=
etica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .</div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0</div><div class=3D"gmail_default" style=3D"font-family:arial,helvet=
ica,sans-serif">=C2=A0rcu_read_lock() =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0</div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Update (C.S1)</div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C.S2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Synchronise_rcu()</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(m=
en_C.S1)</div><div class=3D"gmail_default" style=3D"font-family:arial,helve=
tica,sans-serif">=C2=A0 <font color=3D"#ff0000">rcu_read_unlock() </font>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,helveti=
ca,sans-serif">=C2=A0synchronize_rcu() wait till end of C.S2?</div><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif">Thank you very much</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
</div></div>

--001a1142865ee978f5052cc05981--


--===============1452902669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1452902669==--
