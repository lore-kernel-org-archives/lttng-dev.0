Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7D9C43334
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Jun 2022 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655221893;
	bh=Vq65LVDVva6jcl9Y4ezK0/3FQkWRv2IMc2g35n0E7s8=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Yy0BdSYM12Vmgd9Sxc7gN+zxtXpWMnSMIGZTDp/e9vunAAxLcJXLvZEdXhdLr6GQi
	 JUczGGk0IxMt6WKrFVk+RDukg8j6ot+yIcVzyRz34CmYSNinUC2/X3NJJxM8Hjv9VW
	 QwpmeBDyN/B1OlJGdtVr2NMuho7wW063b+K7scZzBW9xSljmsebVMI9eGMu7U1GRju
	 oTg2s/QBBMB33WrUNEddGS5Aq1JxFb+4lPjnavQOZfNn7hi5QuQmwn8SSGbhlWerYn
	 OwXz43lrsTpM8+hrAO4bamdr8z9X2nQmL2+w9NuqzwuRdY8Fo/E8imq/qMeN5RauJU
	 hBCDk2724j5XQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LMtGD6vlxz8Ym;
	Tue, 14 Jun 2022 11:51:32 -0400 (EDT)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4LMtGC1X2Pz85j
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2022 11:51:30 -0400 (EDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDp3xw032004;
 Tue, 14 Jun 2022 15:26:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gmg91tjxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jun 2022 15:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOdyR0+oCtRgzib43CUDRV4Ca0RfCqk6CSbN99SrQFVmTywWBhx2ZXl7NgifnVigRuLgfqb0mTmlgabFHghNKfZgk24Nb9WBraR+aHM5soe44Rse8sKcA97VyQA2/CS8qw7hvpUqVO2H8Z3SxPAjEBKScKReaquLV84IPFeywRNHV7zP9TvMJ0Qqvx2MeVxtUl4G+IQZ4gf51lehelB/KGiO/XuFS7fwy+SVTaYAEiGyIOGXOqWHBFKcV9+1sym4gIfzNdUgt5nGecwef/I+Y08yajDXHKMqSgOIzdEro4vfbVruS8dFs3PJtcuX6vAAvEITsbBvMeU+OqhQjCD52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCwMYjNtZKgOtKth5x2sCDOlYwMgbJdwlxX/zT6lbbM=;
 b=RRuxJg8SC9tEqvubDpR7VLzTs5ujYpIreshFpChixK6u0ewKZGqggcpm2GkDJrj8dWJX4GFCRHEbN1LonoiMc92pL6kne87yHm5P6u7XO7K3WhxP3shr9U1l2XZtIR8BkxC2L/zeQbRSUlzS8KuxFoF2NdRltXuRSnTai6MqQoqmPhsTCSyQ6LaXZGKNLcqOrAuwFtnDu2tTPOQHCsC1EN1c8XosyDNBoSe0+QQlFijF6PuBL7T9nKa5vBj/OfCQnFlfjtorBkjlno4rXoCAbfs6UVd/sW5Kw5l+Ust1B5knoxQSB9JyWoscrBPPEqBep6QR4KBq/81tClSQEmPGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by BN6PR11MB4018.namprd11.prod.outlook.com (2603:10b6:405:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 15:26:25 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8%8]) with mapi id 15.20.5332.023; Tue, 14 Jun 2022
 15:26:25 +0000
Date: Tue, 14 Jun 2022 17:26:58 +0200
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220614152658.GA221522@windriver.com>
References: <20220613114939.GA276938@windriver.com>
 <2029776906.56294.1655133709430.JavaMail.zimbra@efficios.com>
Content-Disposition: inline
In-Reply-To: <2029776906.56294.1655133709430.JavaMail.zimbra@efficios.com>
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3665d84a-4f11-4fd7-4433-08da4e1a3e44
X-MS-TrafficTypeDiagnostic: BN6PR11MB4018:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB4018A870243CEADC3A76B2A992AA9@BN6PR11MB4018.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0NREW5qr5U4o1/KfZwI2Ke36/JaqX072EpPbyHwTwpQm3OLFGUEzzzj4VqMBEV12mdLcGWmTY2DSHbi4v44T/pYLl8IkxOHo0vHYrepaVTWu3dgz2IxfcnTlTgP6LkAQ6T24Vbk8ieIV2FBpw5rYrtQ4w1Q+uTDB0LuBfqkT568U5rrRMx9lMNgFfZRS8r9LrDYk4rvh29ifEEURtJG1FDbrCiq86ZC3x/FgcRCzsMXIFvrxNd95lBkA5Ml6YjDz8q7C+JsUmlYMBMeq/KyzFxbErzynvgTBGt6ojNjSsLkZxyi2ViBBAeNRNDyEoJGr+W2FmBdfiOBcRHFcVHlKrI8Ml7P2ZWafcdmg0QJQCrkWSCNm99nMI3/hB7BTK/ixwCOazFG8B2++yyouk0H3aGZ/E/CfDc43ffQMYy2TfZfh5CvuVSzM0VBTjvhedDRfHZ/HeRoZVUMycxKNRWukuVzIXNIi3P1xfFHMxslSLk5HYbF4en8IO0KLobfiu6ej+KbML9zaKPzQMAF3p4CkqfZR99xVGo77k3wCw7elq7PSPmHeSiUQpNZWEYai4aBkxCTzsQgAeFdEHuCKypGMhElCtj4BUSkjCvq0DXE2ofGUU4nIqVDBl48MzD7/iRCm/uk4TwX5u022pqQKD0TuNN+rtrSVh54Qcvkr/0P6yFurrT7S8rP59SxkloWeviyYm23fCHFVFxkCSgRA9SgX++XuuG5YUacs+uioWfiK84ISqMQO419MSsQMr0INmSYAexD2bDGIxe8e5di8Tx4gY+Xb28xYdUfZCtPrXmcQsYs7f3zHjbAl0tQWZJ75qt0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5617.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66946007)(66556008)(4326008)(44832011)(8676002)(83380400001)(186003)(8936002)(6512007)(36756003)(1076003)(5660300002)(26005)(66476007)(33656002)(53546011)(86362001)(52116002)(316002)(38100700002)(38350700002)(6506007)(966005)(6916009)(6666004)(2906002)(508600001)(6486002)(2616005)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYz2SAL3vB4M9U3wosav2SqDEsyS7Z5eBlcZvzJk+vRm8FtB7jOlyteJRn6Q?=
 =?us-ascii?Q?sc4Ev4iYkaB++C8lO178HqlRdp5/P2s3uA4CgZ4Dqb7s7RyjhW30FFY8yHCL?=
 =?us-ascii?Q?W56Rgi7mHgS+tZELdLHowWPSMbUp7TJeQ/X30UsjLn5r8+o3Jkr314BSSoeR?=
 =?us-ascii?Q?Vjkm3EQ9/1dmlifYOckr55ecOtQNdvrmiO1goFt/TgwFUJqB3jRiEd8ZmRP7?=
 =?us-ascii?Q?oRo5si3YfgPkK9wIIRMmeq4TswQbRTMTjnLLk5c8B07FGTur7KaZRPdVsftQ?=
 =?us-ascii?Q?mg3IQo6Ck5jqGB0N4FVchEcJeGEgpJR2qSTkloQzrg1pH6Ym+0Q4jocFjvzA?=
 =?us-ascii?Q?Fbj4o8vZ0si5wBlHRbNzESYmD8KEB3KobRJ/oGhiAueoZqLZ74tM5oDIDUAP?=
 =?us-ascii?Q?JsQPw61Q9PlR87KvAni1aXKEgbNQKe33mJ9y5MqN8IlCQhwOb8R9MV1rwgZw?=
 =?us-ascii?Q?8nGwefOwZi6J+6g0ZZLAyC5qfeVQt6yBGBl1ojueBwEWWZo4IX2bNMSY7jqN?=
 =?us-ascii?Q?0USTher5aG78EGhMhT1n1cluyEKbvUI31snJJJEuZHR4amErlqsP0xJGU8vZ?=
 =?us-ascii?Q?rPQo8TinfG+x9veJMTGqMAsAr2qDSStjL5yvcCQmronHpMqIkCnavhnWx+w7?=
 =?us-ascii?Q?X+X79IEHyzK9ArykEMxD1dqdvxYtGRd/fejVpnhgAGeW3oIDuWCepjCXl5af?=
 =?us-ascii?Q?TkaEEeZ9e7Z5zFB+GNVmprOHSTeNhv5yR+BbYPQwbyK+zrVKpUrcPKdEnNLy?=
 =?us-ascii?Q?lvjQaQmkO19f6sr4j11BThMMaZfvkDN21EwSMAzYWI574KmIHMuPAUVu8Fmv?=
 =?us-ascii?Q?FFdlOFLp2Ut1z3R1QAOWmKaQWFeJl8mHN6TQQ06drZyFnZ19lHiHSR7d2SVu?=
 =?us-ascii?Q?p5X2XgTfZTKH0BuJrQvgzyaiPHnS5SGuSk2cvOczuCM0NlQFjWaF6eGO09tm?=
 =?us-ascii?Q?YmESqsXJQx2n9AnQv5MI/ca4+eTHnkmr1GGGEUZTwGTFSGdRFEV7Q8CkI8af?=
 =?us-ascii?Q?/SSlV5hzmePNsCTX1McGwVasS88yBwgWQn3brk9Tw2FGj7asPrWb+EkiaOB9?=
 =?us-ascii?Q?xbyp/76UYH0MVyR35fE1R3g0STK+QNqb94trW9qsGIAszaP6mMuvO5V/szV/?=
 =?us-ascii?Q?RXvTTpikw0f1qm3pVOfI3H8GoZw5624G1gRiSrZLMAsXf7+ySshX1+sMf9Tv?=
 =?us-ascii?Q?dD8UBwL9pu9EBCr0aMK+L07GaG9vNNMkqKcy5fXWoXalUO1X3f0RrM309i3A?=
 =?us-ascii?Q?xwRnNM40JsbdCjmmxxB7VnaMKUQvTYV9/wM3UF3w+JRm1lPyUGjy2h2uqSSD?=
 =?us-ascii?Q?wIc2CSmUGwUzxL9F05MgK4cPlkTxI+TxEx4ElRvMykXmnPie/6F2vA07ABU+?=
 =?us-ascii?Q?wlEKErC9b3cu5BPI3QniP4G8gNNKUX+GdqhT5cspnOPnhTvefHtRRMq6qZ+z?=
 =?us-ascii?Q?Khs2YL4u4e1nf3jhE3CaOVApvABc0rFJBZ6/fiyx9X49tJJnHxvdLnCpf1n9?=
 =?us-ascii?Q?LM+6jr3LdA8z4OceIV/HFvJbbXNvs4YQd/30v29bDR/9GI8MUtQVJr7J0Ezi?=
 =?us-ascii?Q?Fk3b1peNwYRdSwbkj6xhnNMwU3URVzgRpE1G2U1m9XucP0BxHO/n8QSbRFEW?=
 =?us-ascii?Q?T1tzOjwu9k6xnKc7MS8opNdiYUZjRc+gpvNVprCyMmP0BybyZz7lURaKCeY/?=
 =?us-ascii?Q?HccoNn5HE40FVICMNLIGcicynVH72BFKFV2JAGkSLOJ2dDyeGjyRyIbE0Vao?=
 =?us-ascii?Q?q/npgKmij8SLU/ON4q59xt8jJ07VDOg=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3665d84a-4f11-4fd7-4433-08da4e1a3e44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 15:26:25.0248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f3HDfb11dwdqe6Z0/P+JGPEqPGnrOtusB74O4hBR4EGuPi3HBi0iUBJYSGYdUxU44/d+E/vXUlf/nZaPhTwnqmiaUi7sTikYs3QpDKVwGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4018
X-Proofpoint-ORIG-GUID: 5NrCPvayexj0lGBiITACetk4NXMUYMP7
X-Proofpoint-GUID: 5NrCPvayexj0lGBiITACetk4NXMUYMP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_05,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140060
Subject: Re: [lttng-dev] [lttng-tools] Removal of root_regression tests
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Marcel Hamer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Marcel Hamer <marcel.hamer@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Jonathan,

On Mon, Jun 13, 2022 at 11:21:49AM -0400, Jonathan Rajotte-Julien wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hi Marcel,
> 
> ----- Original Message -----
> > From: "Marcel Hamer via lttng-dev" <lttng-dev@lists.lttng.org>
> > To: "lttng-dev" <lttng-dev@lists.lttng.org>
> > Sent: Monday, 13 June, 2022 07:49:39
> > Subject: [lttng-dev] [lttng-tools] Removal of root_regression tests
> 
> > Hello,
> >
> > Since version v2.12.9 of lttng-tools the root_regression file has been emptied
> > to make the tests part of the 'make check' sequence instead.
> >
> > We were always actively using that test file as part of our regression testing.
> > In our case we are working in a cross-compilation environment, where the run.sh
> > script was used on target for testing and as such not at compile time. It is not
> > easy to run a make check sequence on a target.
> 
> I would suggest that you take a look at how OpenEmbedded does it with ptest AFAIK it match your requirements:
> 
> https://github.com/openembedded/openembedded-core/blob/c7e2901eacf3dcbd0c5bb91d2cc1d467b4a9aaf7/meta/recipes-kernel/lttng/lttng-tools_2.13.7.bb#L75
> 

That is a very good suggestion. I guess we were a bit too focused on our existing
solution of using run.sh. We will look into this.

> >
> > It is now also a bit unclear which tests actually require root access and which
> > tests do not. I understood this was the reason the file was called
> > 'root_regression'?
> 
> Yes when the tests suites primarily used `prove` via run.sh.
> 
> We have been slowly moving away from it for a good time and now mostly use the Automake test harness as much as possible.
> 
> The worse that will happen if you run a test that required root as a non-root user is that `skip` tap output will be emitted.
> 
> >
> > Some questions that get raised because of this:
> >
> > - Is there now an alternative way to run regressions on target in case of a
> >  cross-compilation environment?
> 
> AFAIU, this is out of scope of the lttng project. Still, I would recommend that you see how yocto/oe do it with ptest.
> 
> > - Would there be a possibility to fill the 'root_regression' file again and
> >  possibly revert this change?
> 
> Feel free to do it out-of-tree. I doubt that we are the only project that WindRiver handles that uses
> the automake test harness and that do not provide a easy way to run on-target for cross-compilation testing.

Yes, you are right and that is a fair point. We will look into the ptest
solution.

> 
> A quick grep with "isroot" should get you 95% there.
> 
> > - How are tests now identified that require root access?
> 
> All tests that require root access test for it at runtime
> 
> Something along:
> 
> regression/tools/streaming/test_high_throughput_limits:
> 
>  if [ "$(id -u)" == "0" ]; then
>         isroot=1
>  else
>          isroot=0
>  fi
> 
>  skip $isroot "Root access is needed to set bandwidth limits. Skipping all tests." $NUM_TESTS ||
>  {
>  ...
>     Tests are done here.
>  }
> 
> Cheers

Thanks for the tip on how to identify test cases that require root privileges.

Kind regards,

Marcel
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
