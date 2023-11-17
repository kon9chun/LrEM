function Eeqp=EeqLMO(socp_surf)
Eeqp=4.19829+0.0565661*tanh(-14.5546*socp_surf+8.60942)-0.0275479*(1./(0.998432-socp_surf).^0.492465-1.90111)...
    -0.157123*exp(-0.04738*socp_surf.^8)+0.810239*exp(-40*(socp_surf-0.133875));
end