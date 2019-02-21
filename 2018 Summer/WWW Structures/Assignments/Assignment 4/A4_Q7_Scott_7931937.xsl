<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body>
                <table border="1">
                    <tr>
                        <th>Nutrition Facts</th>
                    </tr>
                    <tr>
                        <td>
                            <xsl:value-of select="nutrition/product"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Servings (packages)</td>
                        <td>
                            <xsl:value-of select="nutrition/serving"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Calories</td>
                        <td>
                            <xsl:value-of select="nutrition/calories"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Fat Calories</td>
                        <td>
                            <xsl:value-of select="nutrition/fatcalories"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Fat (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/fat"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Saturated Fat (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/saturatedfat"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Cholesterol (mg)</td>
                        <td>
                            <xsl:value-of select="nutrition/cholesterol"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Sodium (mg)</td>
                        <td>
                            <xsl:value-of select="nutrition/sodium"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Carbohydrates (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/carbohydrates"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Fibers (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/fiber"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Sugar (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/sugar"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Protein (g)</td>
                        <td>
                            <xsl:value-of select="nutrition/protein"/>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>