From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng_2.0-eclipse-juno : Connection to a Remote
 Host : Unable to list kernel events
Date: Thu, 05 Jul 2012 10:29:37 -0400
Message-ID: <4FF5A4D1.7080708__9106.19096034697$1341499228$gmane$org@voxpopuli.im>
References: <1341389386.5657.YahooMailNeo@web140904.mail.bf1.yahoo.com>
	<CAG5-hcMDzStCrHp0GpZNZTZfVHZ7+2xDuytSsnZnZmCgpA3Lsw@mail.gmail.com>
	<1341467127.80260.YahooMailNeo@web140905.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1Smn40-0005zM-3n
	for lttng-dev@lists.lttng.org; Thu, 05 Jul 2012 10:29:48 -0400
In-Reply-To: <1341467127.80260.YahooMailNeo@web140905.mail.bf1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: somanath sahoo <bapi_mvit2004@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 12-07-05 01:45 AM, somanath sahoo wrote:
> However i want to know how to make sure my user id present in the tracing group ? is there any command to list or include the users into the "tracing" group ? please enlightened on this.

You can use

$ cat /etc/group | grep tracing

It will list the users that are in the tracing group.


Cheers,
Alex
