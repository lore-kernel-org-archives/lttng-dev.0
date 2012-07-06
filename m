From: somanath sahoo <bapi_mvit2004@yahoo.com>
Subject: Re: lttng_2.0-eclipse-juno : Connection to a Remote
	Host : Unable to list kernel events
Date: Fri, 6 Jul 2012 02:29:21 -0700 (PDT)
Message-ID: <1341566961.89582.YahooMailNeo__33041.60065386$1341567000$gmane$org@web140903.mail.bf1.yahoo.com>
References: <1341389386.5657.YahooMailNeo@web140904.mail.bf1.yahoo.com>
	<CAG5-hcMDzStCrHp0GpZNZTZfVHZ7+2xDuytSsnZnZmCgpA3Lsw@mail.gmail.com>
	<1341467127.80260.YahooMailNeo@web140905.mail.bf1.yahoo.com>
	<4FF5A4D1.7080708@voxpopuli.im>
Reply-To: somanath sahoo <bapi_mvit2004@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1307528136=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm28.bullet.mail.bf1.yahoo.com ([98.139.212.187])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <bapi_mvit2004@yahoo.com>) id 1Sn4qt-0005tD-ND
	for lttng-dev@lists.lttng.org; Fri, 06 Jul 2012 05:29:30 -0400
In-Reply-To: <4FF5A4D1.7080708@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1307528136==
Content-Type: multipart/alternative; boundary="2048499531-1920443446-1341566961=:89582"

--2048499531-1920443446-1341566961=:89582
Content-Type: text/plain; charset=us-ascii

Hi Alex,

your reponse is much more appeciated.


my user id was not present in tracing group in /etc/group.

Now eclipse-remote-control is working great after addition of my user id into the tracing group.

Thanks.



Warm Regards,
Somanath



________________________________
 From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
To: somanath sahoo <bapi_mvit2004@yahoo.com> 
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org> 
Sent: Thursday, July 5, 2012 7:59 PM
Subject: Re: [lttng-dev] lttng_2.0-eclipse-juno : Connection to a Remote Host : Unable to list kernel events
 
On 12-07-05 01:45 AM, somanath sahoo wrote:
> However i want to know how to make sure my user id present in the tracing group ? is there any command to list or include the users into the "tracing" group ? please enlightened on this.

You can use

$ cat /etc/group | grep tracing

It will list the users that are in the tracing group.


Cheers,
Alex
--2048499531-1920443446-1341566961=:89582
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:times new roman, new york, times, serif;font-size:12pt"><div><span>Hi Alex,</span></div><div><br></div><div>your reponse is much more appeciated.<br><span></span></div><div><br><span></span></div><div><span>my user id was not present in tracing group in /etc/group.</span></div><div><span> <br></span></div><div><span>Now eclipse-remote-control is working great after addition of my user id into the tracing group.</span></div><div><br><span></span></div><div>Thanks.<br></div><div><br></div><div><br><span></span><span>Warm Regards,</span></div><div><span>Somanath</span></div><div><br></div>  <div style="font-family: times new roman, new york, times, serif; font-size: 12pt;"> <div style="font-family: times new roman, new yor
 k, times, serif; font-size: 12pt;"> <div dir="ltr"> <font face="Arial" size="2"> <hr size="1">  <b><span style="font-weight:bold;">From:</span></b> Alexandre
 Montplaisir &lt;alexmonthy@voxpopuli.im&gt;<br> <b><span style="font-weight: bold;">To:</span></b> somanath sahoo &lt;bapi_mvit2004@yahoo.com&gt; <br><b><span style="font-weight: bold;">Cc:</span></b> "lttng-dev@lists.lttng.org" &lt;lttng-dev@lists.lttng.org&gt; <br> <b><span style="font-weight: bold;">Sent:</span></b> Thursday, July 5, 2012 7:59 PM<br> <b><span style="font-weight: bold;">Subject:</span></b> Re: [lttng-dev] lttng_2.0-eclipse-juno : Connection to a Remote Host : Unable to list kernel events<br> </font> </div> <br>On 12-07-05 01:45 AM, somanath sahoo wrote:<br>&gt; However i want to know how to make sure my user id present in the tracing group ? is there any command to list or include the users into the "tracing" group ? please enlightened on this.<br><br>You can use<br><br
 >$ cat /etc/group | grep tracing<br><br>It will list the users that are in the tracing group.<br><br><br>Cheers,<br>Alex<br><br><br> </div> </div>  </div></body></html>
--2048499531-1920443446-1341566961=:89582--


--===============1307528136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1307528136==--
