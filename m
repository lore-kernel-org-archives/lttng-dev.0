From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: How to disable an event that's been enabled by a
 wildcard selection or -a? (lttng-dev Digest, Vol 64, Issues 30, 38)
Date: Wed, 4 Sep 2013 09:02:31 +0000
Message-ID: <009B25148989C6458484484699278506E5387790__30550.2744894058$1378285408$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2678BEB2@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<1986194.AcrmLPglby@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VH8z3-0000oZ-Lm
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 05:02:46 -0400
In-Reply-To: <1986194.AcrmLPglby@atv-pwoegere-l3.atv.mentorg.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

What I would like to see is a new command option --exclude as in 

lttng enable-event -u "a*" --exclude "ab*,ac*"

In this syntax, the exclusions would apply to this one enabler only, so you could then call

lttng enable-event -u "abc*"

After these two commands, events such as 'abc' would be enabled (via the second enabler) but an event 'abd' would not get enabled (as it only matches the first enabler but is excluded in it).

However, when I looked into how to implement this, it seemed that the most reasonable solution would require changes to the event interface down to the tracer level structures, which I would not want to have.
For the particular use case that I have in mind, the enable-event "!ab*,!ac*" syntax will be quite sufficient. Using this syntax, the "!"-events override any other enablers. That is, if a new event matches with any "!"-event enabler, the event will not be enabled at all, even if it matches any non-"!"-enablers. In a UST patch I sent earlier, the functionality is exactly this. I also submitted a TOOLS patch for the --exclude option, but that is implemented only as a convenient shortcut to "!" - that is, lttng enable-event -u "a*" --exclude "ab*,ac*" will be interpreted as lttng enable-event -u "!ab*,!ac*,a*" .

Cheers,
JP
