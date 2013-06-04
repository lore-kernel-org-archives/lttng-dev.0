From: David Goulet <dgoulet@ev0ke.net>
Subject: Re: LTTng request to revert patch
 e78de861055e6288d11348866681d1373ed81aec (Improve channel listing output
 format)
Date: Tue, 04 Jun 2013 10:55:36 -0400
Message-ID: <51ADFFE8.3030701__666.865535504435$1370357780$gmane$org@ev0ke.net>
References: <51ADF654.80406@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@ev0ke.net>) id 1UjseG-0001iB-Cr
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 10:55:44 -0400
In-Reply-To: <51ADF654.80406@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This has been reverted. Matthew brought the point that this got in AFTER 2.2-rc1
so I'll keep that in the back burner for 2.3!

"I will not break the API during the RC cycle"
"I will not break the API during the RC cycle"
"I will not break the API during the RC cycle"
"I will not break the API during the RC cycle"
"I will not break the API during the RC cycle"

;)

Thanks!
David

Matthew Khouzam:
> Hello tracing kensais,
> 
> The patch "Improve channel listing output format" SHA1:
> e78de861055e6288d11348866681d1373ed81aec breaks the output api and and
> adds a new feature in the RC.
> 
> I would request that the patch be reverted, and also it should not
> replace the standard text output from before. The LTTng Control in TMF
> is dependant on the text output, therefore this patch breaks the support
> for LTTng control.
> 
> Keep up the great work!
> 
> Matthew
> 
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
